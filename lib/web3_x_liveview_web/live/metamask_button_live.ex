defmodule Web3XLiveviewWeb.MetamaskButtonLive do
  use Web3XLiveviewWeb, :live_view

  alias Web3XLiveview.Accounts
  alias Web3XLiveviewWeb.UserAuth

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign_new(:user_token, fn -> session["user_token"] end)
     |> assign_new(:user, fn -> nil end)
     |> assign_new(:text, fn -> session["text"] end)
     |> assign_new(:id, fn -> session["id"] end)
     |> assign_new(:connected, fn -> false end)
     |> assign_new(:current_wallet_address, fn -> nil end)
     |> assign_new(:signed, fn -> false end)
     |> assign_new(:verify_signature, fn -> false end)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <span title="Metamask" id="metamask-button" phx-hook="Metamask">
      <%= cond do %>
        <% @connected and @id == "metamask-login" -> %>
          <.form
            let={f}
            for={:user}
            action={Routes.user_session_path(@socket, :create)}
            as={:user}
            phx-submit="get-current-wallet"
            phx-trigger-action={@verify_signature}
          >
            <%= hidden_input(f, :user,
              name: :public_address,
              value: if(@user, do: @user.public_address)
            ) %>
            <.button
              icon
              color="white"
              variant="outline"
              class="w-full inline-flex justify-center py-2 px-4 !border-gray-300 !text-gray-500 hover:bg-gray-50"
              phx-click="get-current-wallet"
            >
              <.icon icon="metamask" size="lg" />
              <%= @text %>
            </.button>
          </.form>
        <% @connected and @id == "metamask-connect" -> %>
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
        <% not @connected and @id == "metamask-connect" -> %>
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
        <% true -> %>
      <% end %>
    </span>
    """
  end

  @impl true
  def handle_event("account-check", params, socket) do
    {:noreply,
     socket
     |> assign(:connected, params["connected"])
     |> assign(:current_wallet_address, params["current_wallet_address"])}
  end

  @impl true
  def handle_event("get-current-wallet", _params, socket) do
    {:noreply, push_event(socket, "get-current-wallet", %{})}
  end

  @impl true
  def handle_event("verify-signature", params, socket) do
    user = Accounts.verify_message_signature(params["current_wallet_address"])

    if user do
      {:noreply, socket |> assign(:user, user) |> assign(:verify_signature, true)}
    else
      {:noreply, put_flash(socket, :error, "Unable to verify wallet")}
    end
  end

  @impl true
  def handle_event("connect-metamask", _params, socket) do
    {:noreply, push_event(socket, "connect-metamask", %{id: socket.assigns.id})}
  end

  @impl true
  def handle_event("wallet-connected", params, socket) do
    #    Web3x.Contract.deploy(:VerifySignature, bin: contract["bytecode"], options: %{gas: 3000000, from: params["public_address"]})
    {status, _user_struct_or_changeset} =
      Accounts.add_wallet_and_signature(socket.assigns.user_token, params)

    connected = if status == :ok, do: true, else: false
    {:noreply, assign(socket, :connected, connected)}
  end
end
