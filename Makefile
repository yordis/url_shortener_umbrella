# Starts the database container only. Useful for development and testing
# purposes.
dev-services-start:
	docker compose up -d

# Add the asdf plugins for erlang and elixir
asdf-add-plugins:
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

# Install the erlang and elixir versions specified in the .tool-versions file
asdf-install:
	asdf install
