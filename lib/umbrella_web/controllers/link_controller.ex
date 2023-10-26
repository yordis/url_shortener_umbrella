defmodule UmbrellaWeb.LinkController do
  use UmbrellaWeb, :controller

  alias Umbrella.Links

  def download_stats(conn, _params) do
    csv_data =
      Links.list_links()
      |> Enum.map(&Map.take(&1, [:id, :slug, :visits_count, :redirect_url]))
      |> CSV.encode(
        headers: [id: "UUID", slug: "Slug", visits_count: "Visits", redirect_url: "Redirect URL"]
      )
      |> Enum.to_list()
      |> Kernel.to_string()

    file_name = "#{DateTime.to_unix(DateTime.utc_now(), :second)}.stats.csv"

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", ~s(attachment; filename="#{file_name}"))
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end

  def visit_link(conn, %{"slug" => slug}) do
    case Links.get_link_by_slug(slug) do
      nil ->
        render(conn, :not_found, slug: slug)

      link ->
        Umbrella.async_task(fn -> Links.increment_visits_count(link) end)
        redirect(conn, external: link.redirect_url)
    end
  end
end
