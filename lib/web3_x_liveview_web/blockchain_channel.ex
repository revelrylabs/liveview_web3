defmodule Web3XLiveviewWeb.BlockchainChannel do
  use Web3XLiveviewWeb, :channel

  alias Web3XLiveview.Accounts
  alias Web3XLiveviewWeb.Presence

  def join("blockchain:presence", params, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :user_id, "params.user.id")}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  def fetch(_topic, presences) do
    users = presences |> Map.keys() |> Accounts.get_users_map()

    for {key, %{metas: metas}} <- presences, into: %{} do
      {key, %{metas: metas, user: users[String.to_integer(key)]}}
    end
  end
end
