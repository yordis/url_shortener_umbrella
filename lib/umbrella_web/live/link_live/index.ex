defmodule UmbrellaWeb.LinkLive.Index do
  use UmbrellaWeb, :live_view

  alias Umbrella.Links
  alias Umbrella.Links.Link

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :links, Links.list_links())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Link")
    |> assign(:link, %Link{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Stats")
    |> assign(:link, nil)
  end

  @impl true
  def handle_info({UmbrellaWeb.LinkLive.FormComponent, {:saved, link}}, socket) do
    {:noreply, stream_insert(socket, :links, link)}
  end
end
