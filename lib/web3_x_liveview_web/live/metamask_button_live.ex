defmodule Web3XLiveviewWeb.MetamaskButtonLive do
  use Web3XLiveviewWeb, :live_view

  alias Web3XLiveview.Accounts

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_new(:user_token, fn -> session["user_token"] end)
     |> assign_new(:text, fn -> session["text"] end)
     |> assign_new(:id, fn -> session["id"] end)
     |> assign_new(:connected, fn -> false end)
     |> assign_new(:signed, fn -> false end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <span title="Metamask" id="metamask-button" phx-hook="Metamask">
      <%= if @connected do %>
        <.button
          icon
          disabled
          color="success"
          variant="outline"
          class="w-full inline-flex justify-center py-2 px-4"
        >
          <.icon icon="metamask" size="lg" />
          <%= gettext("Metamask Connected!") %>
        </.button>
      <% else %>
        <.button
          icon
          color="white"
          variant="outline"
          class="w-full inline-flex justify-center py-2 px-4 !border-gray-300 !text-gray-500 hover:bg-gray-50"
          id={@id}
          phx-click="connect-metamask"
        >
          <.icon icon="metamask" size="lg" />
          <%= @text %>
        </.button>
      <% end %>
    </span>
    """
  end

   @impl true
  def handle_event("account-check", params, socket) do
    {:noreply, assign(socket, :connected, params["connected"])}
  end

  @impl true
  def handle_event("connect-metamask", params, socket) do
    {:noreply, push_event(socket, "connect-metamask", %{id: socket.assigns.id})}
  end

  @impl true
  def handle_event("wallet-connected", params, socket) do

    Accounts.add_wallet_and_signature(socket.assigns.user_token, params)


    {:noreply, assign(socket, :connected, true)}
  end
end
