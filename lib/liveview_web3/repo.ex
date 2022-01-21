defmodule LiveviewWeb3.Repo do
  use Ecto.Repo,
    otp_app: :liveview_web3,
    adapter: Ecto.Adapters.Postgres
end
