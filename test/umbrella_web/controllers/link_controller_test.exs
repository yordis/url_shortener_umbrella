defmodule UmbrellaWeb.LinkControllerTest do
  use UmbrellaWeb.ConnCase

  import Umbrella.LinksFixtures

  describe "visit a link" do
    test "redirects when the slug is found", %{conn: conn} do
      link = link_fixture()
      conn = get(conn, ~p"/#{link.slug}")
      assert redirected_to(conn) == link.redirect_url
      assert link = Umbrella.Links.get_link_by_slug(link.slug)
      assert link.visits_count == 1
    end

    test "returns 404 when the slug is not found", %{conn: conn} do
      conn = get(conn, ~p"/invalid-slug")
      assert html_response(conn, 200) =~ "Link not found"
    end
  end

  describe "download stats" do
    test "downloads stats", %{conn: conn} do
      link = link_fixture()
      conn = post(conn, ~p"/stats/download")
      [content_disposition] = get_resp_header(conn, "content-disposition")
      assert response(conn, 200)
      assert conn.resp_body =~ link.id
      assert conn.resp_body =~ link.slug
      assert conn.resp_body =~ link.redirect_url
      assert response_content_type(conn, :csv) =~ "charset=utf-8"
      assert content_disposition =~ ".stats.csv"
      assert content_disposition =~ "attachment"
    end
  end
end
