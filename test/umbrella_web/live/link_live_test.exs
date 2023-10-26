defmodule UmbrellaWeb.LinkLiveTest do
  use UmbrellaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Umbrella.LinksFixtures

  @create_attrs %{slug: "someSlug", redirect_url: "https://elixir-lang.org"}
  @invalid_attrs %{slug: nil, redirect_url: nil}

  describe "Index" do
    test "lists all links", %{conn: conn} do
      link = link_fixture()
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Stats"
      assert html =~ link.slug
    end

    test "saves new link", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("a", "New Link") |> render_click() =~
               "New Link"

      assert_patch(index_live, ~p"/new")

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#link-form", link: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stats")

      html = render(index_live)
      assert html =~ "Link created successfully"
      assert html =~ "someSlug"
    end

    test "generating a slug", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      assert index_live |> element("a", "New Link") |> render_click() =~
               "New Link"

      assert_patch(index_live, ~p"/new")

      assert index_live
             |> form("#link-form", link: @create_attrs)
             |> render_change() =~ "someSlug"

      refute index_live
             |> element("button", "Regenerate Slug")
             |> render_click() =~ "someSlug"
    end
  end
end
