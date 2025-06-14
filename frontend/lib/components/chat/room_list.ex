defmodule Frontend.Components.Chat.RoomList do
  @behaviour Tamnoon.Component

  @impl true
  def heex() do
    ~S"""
      <ul class="menu bg-base-100 rounded-box w-50 overflow-y-auto h-full flex-nowrap">
        <%= if !is_nil(@rooms) do %>
          <% import Frontend.Components.Chat.RoomList %>
          <%= for room <- @rooms do %>
            <%= menu_item(room) %>
          <% end %>
        <% end %>
      </ul>
    """
  end

  def menu_item(%{"id" => id, "name" => name}) do
    ~s"""
    <li>
      <button class="menu-item" onclick=@switch_room value=#{id}>#{name}</button>
    </li>
    """
  end
end
