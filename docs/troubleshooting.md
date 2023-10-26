# Troubleshooting

## Database is not running

It may be the case you come across the following error:

```txt
21:39:04.410 [error] Postgrex.Protocol (#PID<0.212.0>) failed to connect: ** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused
21:39:04.418 [error] Postgrex.Protocol (#PID<0.218.0>) failed to connect: ** (DBConnection.ConnectionError) tcp connect (localhost:5432): connection refused - :econnrefused
** (Mix) The database for Umbrella.Repo couldn't be created: killed
```

That is most likely because the database is not running. Run the following command to start the database:

  ```bash
  make dev-services-start
  ```

## Can not start the web application

It may be the case you come across the following error:

```txt
[error] Failed to start Ranch listener UmbrellaWeb.Endpoint.HTTP in :ranch_tcp:listen([cacerts: :..., key: :..., cert: :..., ip: {127, 0, 0, 1}, port: 4000]) for reason :eaddrinuse (address already in use)

[error] Running UmbrellaWeb.Endpoint with cowboy 2.10.0 at http failed, port already in use
[notice] Application umbrella exited: Umbrella.Application.start(:normal, []) returned an error: shutdown: failed to start child: UmbrellaWeb.Endpoint
    ** (EXIT) shutdown: failed to start child: {:ranch_listener_sup, UmbrellaWeb.Endpoint.HTTP}
        ** (EXIT) shutdown: failed to start child: :ranch_acceptors_sup
            ** (EXIT) {:listen_error, UmbrellaWeb.Endpoint.HTTP, :eaddrinuse}
```

That is most likely because another (or you have it somewhere running) service is already running on port `4000`.
Run the following command to find out which service is running on that port:

  ```bash
  lsof -i :4000
  ```

Run the following command to stop the service running on that port:

  ```bash
  kill -9 <PID>
  ```
