defmodule Umbrella.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string, null: false
      add :redirect_url, :string, null: false
      add :visits_count, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:links, [:slug])
  end
end
