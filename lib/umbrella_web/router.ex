defmodule UmbrellaWeb.Router do
  use UmbrellaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {UmbrellaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", UmbrellaWeb do
    pipe_through :browser

    post "/stats/download", LinkController, :download_stats
    live "/stats", LinkLive.Index, :index
    live "/new", LinkLive.Index, :new
    live "/", LinkLive.Index, :new
    get "/:slug", LinkController, :visit_link
  end

  if Application.compile_env(:umbrella, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: UmbrellaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
