defmodule ForemWeb.NavLive do
  use ForemWeb, :live_view
  import ForemWeb.Components.Icons

  def mount(_params, session, socket) do
    current_user = Map.get(session, "current_user")
    {:ok, assign(socket, current_user: current_user, is_nav_open: false)}
  end

  def handle_event("toggle_nav", _, socket) do
    {:noreply, update(socket, :is_nav_open, &(!&1))}
  end

  def render(assigns) do
    ~H"""
    <header class="w-full border-b-4 border-black">
      <nav class="font-inter mx-auto h-auto w-full lg:relative lg:top-0">
        <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between px-4 sm:px-6 lg:px-8 py-6 lg:py-4">
          <div class="flex justify-between items-center lg:w-1/4">
            <a href="#"><span>LOGO</span></a>
            <a phx-click="toggle_nav" href="#" class="lg:hidden">
              <.burger_icon />
            </a>
          </div>
          <!-- Center links for desktop -->
          <div class="hidden lg:flex lg:justify-center lg:items-center lg:w-1/2">
            <div class="lg:flex lg:space-x-4">
              <a href="#" class="font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800">Communities</a>
              <a href="#" class="font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800">Search</a>
              <a href="#" class="font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800">About</a>
              <a href="#" class="font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800">FAQs</a>
            </div>
          </div>
          <!-- Authentication links for desktop -->
          <div class="hidden lg:flex lg:items-center lg:justify-end lg:w-1/4">
            <%= if @current_user do %>
              <span class="text-[0.8125rem] leading-6 text-zinc-900 mr-4">
                <%= @current_user.email %>
              </span>
              <a href={~p"/users/settings"} class="font-inter px-4 py-2 hover:bg-gray-100">
                Settings
              </a>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class="font-inter bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
                data-confirm="Are you sure you want to log out?"
              >
                Log out
              </.link>
            <% else %>
              <a href={~p"/users/register"} class="font-inter px-4 py-2 hover:bg-gray-100">
                Register
              </a>
              <a
                href={~p"/users/log_in"}
                class="font-inter bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
              >
                Log in
              </a>
            <% end %>
          </div>
          <!-- Mobile navigation -->
          <div class={[
            "mt-4 lg:hidden",
            if(@is_nav_open, do: "block", else: "hidden")
          ]}>
            <div class="flex flex-col space-y-2">
              <a href="#" class="block py-2 font-inter">Communities</a>
              <a href="#" class="block py-2 font-inter">Search</a>
              <a href="#" class="block py-2 font-inter">About</a>
              <a href="#" class="block py-2 font-inter">FAQs</a>
              <!-- Authentication links for mobile -->
              <%= if @current_user do %>
                <span class="text-[0.8125rem] leading-6 text-zinc-900">
                  <%= @current_user.email %>
                </span>
                <a
                  href={~p"/users/settings"}
                  class="font-inter px-4 py-2 text-center hover:bg-gray-100"
                >
                  Settings
                </a>
                <a
                  href={~p"/users/log_out"}
                  class="font-inter bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
                  data-method="delete"
                >
                  Log out
                </a>
              <% else %>
                <a
                  href={~p"/users/register"}
                  class="font-inter px-4 py-2 text-center hover:bg-gray-100"
                >
                  Register
                </a>
                <a
                  href={~p"/users/log_in"}
                  class="font-inter bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
                >
                  Log in
                </a>
              <% end %>
            </div>
          </div>
        </div>
      </nav>
    </header>
    """
  end
end
