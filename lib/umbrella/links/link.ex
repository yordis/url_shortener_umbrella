defmodule Umbrella.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @slug_length 11

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "links" do
    field :redirect_url, :string
    field :slug, :string
    field :visits_count, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking `Link` changes.
  """
  def changeset(%__MODULE__{} = link, attrs \\ %{}) do
    link
    |> cast(attrs, [:slug, :redirect_url])
    |> validate_required([:redirect_url, :visits_count])
    |> unique_constraint(:slug)
    |> validate_format(:slug, ~r/^[a-zA-Z0-9-_]+$/)
    |> validate_url(:redirect_url)
    |> ensure_slug()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking `Link` changes with a random slug.
  """
  def put_random_slug_changeset(link, attrs) do
    link
    |> cast(attrs, [:slug, :redirect_url])
    |> put_random_slug()
  end

  defp put_random_slug(changeset) do
    put_change(changeset, :slug, generate_slug())
  end

  defp validate_url(changeset, field) do
    validate_change(changeset, field, fn field, value ->
      case URI.parse(value) do
        %URI{scheme: scheme, host: host} when scheme in ["http", "https"] and host != nil ->
          []

        _ ->
          [{field, "must be a valid URL"}]
      end
    end)
  end

  defp ensure_slug(changeset) do
    case get_field(changeset, :slug) do
      nil ->
        put_random_slug(changeset)

      _slug ->
        changeset
    end
  end

  defp generate_slug do
    @slug_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
    |> binary_part(0, @slug_length)
  end
end
