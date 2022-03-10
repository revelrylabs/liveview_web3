defmodule LiveviewWeb3Web.Page do
  @moduledoc """
  Establishes Page component for Carmacare App
  """
  use LiveviewWeb3Web, :component

  def page(assigns) do
    ~H"""
    <body>
      <div class="flex flex-col h-screen content-start bg-primary w-full">
        <div class="flex flex-col !bg-gradient-to-br from-slate-200 to-white">
          <div class="flex flex-col w-full">
            <%= render_slot(@inner_block) %>
          </div>
        </div>
      </div>
    </body>
    """
  end
end
