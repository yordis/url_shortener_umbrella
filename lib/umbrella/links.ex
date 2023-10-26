defmodule Umbrella.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Umbrella.Repo

  alias Umbrella.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a link by slug.

  ## Examples

      iex> get_link_by_slug("some-slug")
      %Link{}

      iex> get_link_by_slug("not-found-slug")
      nil

  """
  def get_link_by_slug(slug), do: Repo.get_by(Link, slug: slug)

  @doc """
  Increments the visits count of a link.
  """
  def increment_visits_count(%Link{} = link) do
    query =
      from l in Link,
        where: l.id == ^link.id,
        update: [inc: [visits_count: 1]]

    case Repo.update_all(query, []) do
      {1, _} ->
        :ok

      _ ->
        {:error, "could not increment visits count"}
    end
  end
end
