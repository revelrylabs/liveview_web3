defmodule Web3XLiveviewWeb.Presence do
  use Phoenix.Presence,
    otp_app: :web3_x_liveview,
    pubsub_server: Web3XLiveview.PubSub
end
