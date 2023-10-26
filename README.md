# Umbrella

Welcome to URL Shortener App!.

> This project is following https://diataxis.fr/ documentation framework.

## How-to Guides

- [How-To Contribute](CONTRIBUTING.md)

## References

- [Deployment](docs/deployment.md)
- [Troubleshooting](docs/troubleshooting.md)

### Helpful Commands

- `mix coveralls.html`: run all Elixir tests and generate a coverage report.
- `mix test.ecto.reset`: reset the database for the test environment.
- `mix phx.server`: run the web server.
- `mix phx.routes`: list all routes.
- `mix docs`: generate documentation.

## Explanations

### About Umbrella Namespace for Modules

Yordis used to come up with a "namespace" for the modules based on the project name, he still does but situational.
After a while Yordis noticed that it was a bit annoying to have to remove the namespace when moving the modules to
another project, or when asking for help in the community. So he started using `Umbrella` as a generic enough namespace
for the modules.
