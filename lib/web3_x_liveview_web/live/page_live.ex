defmodule Web3XLiveviewWeb.PageLive do
  use Web3XLiveviewWeb, :live_view

  alias Web3XLiveview.{Accounts, PubSub}
  alias Web3XLiveviewWeb.Presence

  @presence "blockchain:presence"

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    if connected?(socket) do
      {:ok, _} =
        Presence.track(self(), @presence, user.id, %{
          user_id: user.id,
          joined_at: :os.system_time(:seconds),
          transactions: nil
        })

      Phoenix.PubSub.subscribe(PubSub, @presence)
    end

    %{transactions: transactions, filter_ids: filter_ids} =
      Web3XLiveview.SmartContracts.listen_for_events(user, [], [])

    {:ok,
     socket
     |> assign(:transactions, transactions)
     |> assign(:user, user)
     |> assign(:filter_ids, filter_ids)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.container>
      <div class="flex justify-center py-4">
        <.h2>Transactions</.h2>
      </div>
      <div class="flex place-content-end">
        <div class="flex">
      <!--    <div class="p-2">
            <.button
              size="lg"
              label="Mint NFT"
              class="ml-auto"
              phx-hook="Metamask"
              phx-click="mint-nft"
              id="nft-button"
            />
          </div> -->
          <div class="p-2">
            <.button
              size="lg"
              label="Coin Transaction"
              class="ml-auto"
              phx-hook="Metamask"
              phx-click="coin-transaction"
              id="coin-button"
            />
          </div>
        </div>
      </div>

      <div class="pt-6 !overflow-x-auto">
        <.table class="">
          <.tr>
            <.th>Contract Name</.th>
            <.th>Transaction Hash</.th>
            <.th>To</.th>
            <.th>From</.th>
            <.th>Details</.th>
            <.th>Token ID</.th>
          </.tr>

          <%= for transaction <- @transactions do %>
            <.table_row transaction={transaction} user={@user} />
          <% end %>
        </.table>
      </div>
    </.container>
    """
  end

  defp table_row(assigns) do
    ~H"""
    <.tr>
      <.td><%= Web3XLiveview.SmartContracts.contract_name_by_address(@transaction["address"]) %></.td>
      <.td><%= @transaction["transactionHash"] %></.td>
      <.td>
        <%= if is_nil(@transaction["to"]), do: @transaction["owner"], else: @transaction["to"] %>
      </.td>
      <.td>
        <%= if is_nil(@transaction["from"]), do: @transaction["approved"], else: @transaction["from"] %>
      </.td>
      <.td><%= format_value(@transaction["value"]) %></.td>
      <.td><%= format_token_id(@transaction["token_id"]) %></.td>
    </.tr>
    """
  end

  @impl true
  def handle_event("mint-nft", params, socket) do
    {contract_name, contract_address} =
      contract_data = Web3XLiveview.SmartContracts.contract_data_by_name(:Token)

    {:noreply, push_event(socket, "mint-nft", %{contract_address: contract_address, user_address: socket.assigns.user.public_address})}
  end

  @impl true
  def handle_event("coin-transaction", params, socket) do
    {_contract_name, contract_address} = Web3XLiveview.SmartContracts.contract_data_by_name(:MetaCoin)

    {:noreply,
     push_event(socket, "coin-transaction", %{
       contract_address: contract_address,
       to_address: "0x387386e5b2d973b36ed0f8a73a62231edd51e031"
     })}
  end

  @impl true
  def handle_info(%{transactions: transactions}, socket) do
    user = socket.assigns.user
    presence = Web3XLiveviewWeb.Presence.get_by_key("blockchain:presence", user.id)

    if is_map(presence) do
      Web3XLiveview.SmartContracts.listen_for_events(user, transactions, socket.assigns.filter_ids)
    end

    {:noreply, assign(socket, transactions: transactions)}
  end

  @impl true
  def handle_info(_params, socket) do
    {:noreply, socket}
  end

  defp format_value(nil), do: "--"
  defp format_value(value), do: "value: #{value}"
  defp format_token_id(nil), do: "--"
  defp format_token_id(token_id), do: token_id
end
