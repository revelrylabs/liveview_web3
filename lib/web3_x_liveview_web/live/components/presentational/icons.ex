defmodule Web3XLiveviewWeb.Live.Components.Icons do
  @moduledoc """
  # <.icon icon="office" class="text-secondary" size="sm" />
  """
  use Phoenix.Component

  def icon(assigns) do
    ~H"""
    <svg class={
      "fill-current #{if assigns[:class], do: @class, else: ""} #{if assigns[:size], do: get_icon_size(@size), else: "h-6 w-6"}"
    }>
      <use xlink:href={"/images/icons.svg#icon-#{@icon}"}></use>
    </svg>
    """
  end

  defp get_icon_size("xs"), do: "h-3 w-3"
  defp get_icon_size("sm"), do: "h-4 w-4"
  defp get_icon_size("md"), do: "h-5 w-5"
  defp get_icon_size("lg"), do: "h-8 w-8"
  defp get_icon_size("xl"), do: "h-10 w-10"
  defp get_icon_size("xxl"), do: "h-18 w-18"
end
