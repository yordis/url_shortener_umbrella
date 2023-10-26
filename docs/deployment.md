# Deployment

### Environment Variables

- **DATABASE_URL**: This is the URL of the database server. It should include the hostname, port, and authentication
  information necessary to connect to the database.
- **DATABASE_APP_NAME**: This is the name of the database application. It is used to identify the application within the
  database server.
- **SECRET_KEY_BASE**: This is a secret key used for verifying the integrity of signed cookies. It should be a random
  string of a sufficient length to ensure security.
- **PHX_HOST**: This is the hostname of the machine where the Phoenix server is running.
- **POOL_SIZE**: This is the size of the database connection pool. It determines how many database connections can be
  held concurrently by the application.
- **ECTO_IPV6**: This specifies whether the application should use IPv6 when connecting to the database. It should be
  set to true to enable IPv6, or false to use IPv4.
- **PHX_SERVER**: This specifies whether the Phoenix server should be started when the application starts. It should be
  set to true to start the server, or false to not start the server.
- **PORT**: This is the port on which the application will listen for incoming requests.

## Links

- [Phoenix Deployment Guides](https://hexdocs.pm/phoenix/deployment.html)
