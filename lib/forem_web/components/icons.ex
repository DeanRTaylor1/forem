defmodule ForemWeb.Components.Icons do
  use Phoenix.Component

  def burger_icon(assigns) do
    ~H"""
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M3.75 12H20.25"
        stroke="#160042"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
      </path>
      <path
        d="M3.75 6H20.25"
        stroke="#160042"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
      </path>
      <path
        d="M3.75 18H20.25"
        stroke="#160042"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
      </path>
    </svg>
    """
  end
end
