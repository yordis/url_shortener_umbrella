defmodule Umbrella.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UmbrellaWeb.Telemetry,
      Umbrella.Repo,
      {DNSCluster, query: Application.get_env(:umbrella, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Umbrella.PubSub},
      {Finch, name: Umbrella.Finch},
      UmbrellaWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Umbrella.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    UmbrellaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
