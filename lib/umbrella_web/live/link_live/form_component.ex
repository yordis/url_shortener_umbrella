defmodule UmbrellaWeb.LinkLive.FormComponent do
  use UmbrellaWeb, :live_component

  alias Umbrella.Links
  alias Umbrella.Links.Link

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="link-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="flex gap-3 items-end">
          <.input field={@form[:slug]} type="text" label="Slug" />
          <.button type="button" phx-click="generate_slug" phx-target={@myself}>
            Regenerate Slug
          </.button>
        </div>
        <.input field={@form[:redirect_url]} type="text" label="Redirect URL" />
        <:actions>
          <.button phx-disable-with="Saving...">Create Short Link</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{link: link} = assigns, socket) do
    changeset = Link.changeset(link)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"link" => link_params}, socket) do
    changeset =
      socket.assigns.link
      |> Link.changeset(link_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("generate_slug", _params, socket) do
    changeset = Link.put_random_slug_changeset(socket.assigns.link, socket.assigns.form.params)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"link" => link_params}, socket) do
    save_link(socket, socket.assigns.action, link_params)
  end

  defp save_link(socket, :new, link_params) do
    case Links.create_link(link_params) do
      {:ok, link} ->
        notify_parent({:saved, link})

        {:noreply,
         socket
         |> put_flash(:info, "Link created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
