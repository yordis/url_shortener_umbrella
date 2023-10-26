defmodule Umbrella.LinksTest do
  use Umbrella.DataCase

  alias Umbrella.Links

  describe "links" do
    alias Umbrella.Links.Link

    import Umbrella.LinksFixtures

    @invalid_attrs %{redirect_url: nil, slug: nil, visits_count: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links() == [link]
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{redirect_url: "https://elixir-lang.org", slug: "someSlug"}

      assert {:ok, %Link{} = link} = Links.create_link(valid_attrs)
      assert link.redirect_url == "https://elixir-lang.org"
      assert link.slug == "someSlug"
      assert link.visits_count == 0
    end

    test "create_link/1 with an auto-generated slug creates a link" do
      valid_attrs = %{redirect_url: "https://elixir-lang.org"}

      assert {:ok, %Link{} = link} = Links.create_link(valid_attrs)
      assert link.redirect_url == "https://elixir-lang.org"
      assert link.slug
      assert String.length(link.slug) == 11
      assert link.visits_count == 0
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "get_link_by_slug/2 with a valid slug" do
      link = link_fixture()
      assert Links.get_link_by_slug(link.slug)
    end

    test "get_link_by_slug/2 with a slug that does not exists" do
      refute Links.get_link_by_slug("not-found-slug")
    end

    test "increment_count/2 increments the link visits count" do
      link = link_fixture()
      assert :ok = Links.increment_visits_count(link)
      assert updated_link = Links.get_link_by_slug(link.slug)
      assert link.visits_count + 1 == updated_link.visits_count
    end
  end
end
