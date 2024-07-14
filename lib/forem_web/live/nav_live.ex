defmodule ForemWeb.NavLive do
  use ForemWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, is_nav_open: false)}
  end

  def handle_event("toggle_nav", _, socket) do
    {:noreply, update(socket, :is_nav_open, &(!&1))}
  end

  def render(assigns) do
    ~H"""
    <header class="px-4 sm:px-6 lg:px-8">
      <nav class="font-inter mx-auto h-auto w-full max-w-screen-2xl lg:relative lg:top-0">
        <div class="flex flex-col px-6 py-6 lg:flex-row lg:items-center lg:justify-between lg:px-10 lg:py-4 xl:px-20">
          <div class="flex justify-between items-center">
            <a href="#"><span>LOGO</span></a>
            <a phx-click="toggle_nav" href="#" class="lg:hidden">
              <svg
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
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
            </a>
          </div>

          <div class={[
            "mt-4 lg:mt-0 lg:flex lg:flex-grow lg:items-center lg:justify-center",
            if(@is_nav_open, do: "block", else: "hidden lg:flex")
          ]}>
            <div class="flex flex-col lg:flex-row lg:items-center">
              <div class="lg:flex lg:space-x-4">
                <a
                  href="#"
                  class="block py-2 lg:inline-block font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800"
                >
                  Communities
                </a>
                <a
                  href="#"
                  class="block py-2 lg:inline-block font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800"
                >
                  Search
                </a>
                <a
                  href="#"
                  class="block py-2 lg:inline-block font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800"
                >
                  About
                </a>
                <a
                  href="#"
                  class="block py-2 lg:inline-block font-inter lg:px-4 lg:py-2 lg:hover:text-gray-800"
                >
                  FAQs
                </a>
              </div>
              <!-- Mobile buttons (inside the toggle-able div) -->
              <div class="mt-4 flex flex-col space-y-2 lg:hidden">
                <a href="#" class="font-inter rounded-lg px-4 py-2 text-center hover:bg-gray-100">
                  Sign Up
                </a>
                <a
                  class="font-inter rounded-lg bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
                  href="#"
                >
                  Login
                </a>
              </div>
            </div>
          </div>
          <!-- Desktop buttons (outside the toggle-able div) -->
          <div class="hidden lg:flex lg:items-center lg:space-x-3">
            <a href="#" class="font-inter rounded-lg px-4 py-2 hover:bg-gray-100">
              Sign Up
            </a>
            <a
              class="font-inter rounded-lg bg-black px-6 py-2 text-center text-white hover:bg-gray-800"
              href="#"
            >
              Login
            </a>
          </div>
        </div>
      </nav>
    </header>
    """
  end
end
