defmodule Umbrella do
  @moduledoc """
  Umbrella keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @task_module Application.compile_env(:umbrella, :task_module, Task)

  defdelegate async_task(func), to: @task_module, as: :async
end
