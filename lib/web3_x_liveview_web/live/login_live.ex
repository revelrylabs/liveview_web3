defmodule Web3XLiveviewWeb.LoginLive do
  use Web3XLiveviewWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign_new(:error_message, fn -> nil end)}
  end
end
