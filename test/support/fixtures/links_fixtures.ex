defmodule Umbrella.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Umbrella.Links` context.
  """

  @doc """
  Generate a unique link slug.
  """
  def unique_link_slug, do: "someSlug#{System.unique_integer([:positive])}"

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        redirect_url: "https://elixir-lang.org",
        slug: unique_link_slug()
      })
      |> Umbrella.Links.create_link()

    link
  end
end
