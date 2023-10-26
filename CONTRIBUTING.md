# How-To Contribute Guide

This guide will help you to contribute to this project.

> You may also find useful to read [Troubleshooting](docs/troubleshooting.md) when you are facing issues.

## Table of Contents

- [Pre-requisites](#pre-requisites)
- [Forking and Cloning the Repository](#forking-and-cloning-the-repository)
- [Installing Elixir and Erlang](#installing-elixir-and-erlang)
- [Running the dependencies services](#running-the-dependencies-services)
- [Modifying the code](#modifying-the-code)
  - [Running the tests](#running-the-tests)
  - [Running the Web Application](#running-the-web-application)
  - [Committing and Pushing the changes](#committing-and-pushing-the-changes)

## Pre-requisites

They are few tools you need to have installed in your machine to be able to contribute to this project:

- `make`: https://www.gnu.org/software/make/ to run the project's `Makefile`.
- `docker`: https://www.docker.com/ to run the project's container.
- `git`: https://git-scm.com/ to clone the project's repository.
- `asdf`: https://asdf-vm.com/ to manage the project's dependencies.

## Forking and Cloning the Repository

Visit https://github.com/yordis/url_shortener_umbrella and click the "Fork" button.

Clone your forked repository to your local machine:

  ```bash
  git clone https://github.com/[my github handler]/url_shortener_umbrella
  cd url_shortener_umbrella
  ```

Create a new branch for your feature:

  ```bash
  git checkout -b my-new-branch
  ```

## Installing Elixir and Erlang

Run the following command to install the required `asdf` plugins:

  ```bash
  make asdf-add-plugins
  ```

Run the following command to install the required `Elixir` and `Erlang` versions:

  ```bash
  make asdf-install
  ```

## Running the dependencies services

Run the following command to start the project's dependencies services:

  ```bash
  make dev-services-start
  ```

## Modifying the code

Open the project's code in your favorite editor and start modifying it.

### Running the tests

Run the following command to run the project's tests:

  ```bash
  mix test
  ```

### Running the Web Application

Run the following command to run the project's web application:

  ```bash
  mix ecto.setup
  mix phx.server
  ```

Visit http://localhost:4000/ to see the web application running.

## Committing and Pushing the changes

Run the following command to commit your changes:

  ```bash
  git add .
  git commit -m "My changes"
  ```

Run the following command to push your changes to your forked repository:

  ```bash
  git push origin my-new-branch
  ```

Create a Pull Request from your forked repository to the original repository.
