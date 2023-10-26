# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Umbrella.Repo.insert!(%Umbrella.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, _} =
  Umbrella.Links.create_link(%{slug: "GkOu8gbocVL", redirect_url: "https://elixir-lang.org"})
