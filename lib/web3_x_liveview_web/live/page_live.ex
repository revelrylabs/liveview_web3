defmodule Web3XLiveviewWeb.PageLive do
  use Web3XLiveviewWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.container>
      <div class="flex justify-center py-4">
        <.h2>Transactions</.h2>
      </div>
      <div class="flex place-content-between">
        <div class="flex place-content-start">
          <%= live_render(@socket, Web3XLiveviewWeb.MetamaskButtonLive,
            id: "connect",
            session: %{"id" => "metamask-connect", "text" => "Connect to Metamask"}
          ) %>
        </div>
        <div class="flex place-content-end">
          <div class="p-2">
            <.button size="lg" label="Mint NFT" class="ml-auto" to="/" />
          </div>
          <div class="p-2">
            <.button size="lg" label="Coin Transaction" class="ml-auto" to="/" />
          </div>
        </div>
      </div>

      <div class="pt-6">
        <.table>
          <.tr>
            <.th>Public Address</.th>
            <.th>Contract Name</.th>
            <.th>Method Called</.th>
            <.th>Email</.th>
          </.tr>

          <.tr>
            <.td>
              John Smith
            </.td>
            <.td>Engineer</.td>
            <.td>john.smith@example.com</.td>
          </.tr>

          <.tr>
            <.td>
              Beth Springs
            </.td>
            <.td>Developer</.td>
            <.td>beth.springs@example.com</.td>
          </.tr>

          <.tr>
            <.td>
              Peter Knowles
            </.td>
            <.td>Programmer</.td>
            <.td>Peter.knowles@example.com</.td>
          </.tr>

          <.tr>
            <.td>
              Sarah Hill
            </.td>
            <.td>Marketer</.td>
            <.td>sarah.hill@example.com</.td>
          </.tr>
        </.table>
      </div>
    </.container>
    """
  end

  defp table_row(assigns) do
    ~H"""
    <.tr>
      <.td>
        John Smith
      </.td>
      <.td>Engineer</.td>
      <.td>john.smith@example.com</.td>
    </.tr>
    """
  end
end
