defmodule Frontend.Components.Chat.MessageList do
  @behaviour Tamnoon.Component

  @impl true
  def heex() do
    ~S"""
    <div class="messages-list h-full overflow-y-auto">
      <%= if !is_nil(@messages) and @messages != [] do %>
        <% import Frontend.Components.Chat.MessageList %>

        <%= for message <- @messages do %>
          <%= message_item(message, @user_id) %>
        <% end %>

      <% else %>
        <p>No messages yet.</p>
      <% end %>
    </div>
    """
  end

  def message_item(message_data, user_id) do
    ~s"""
    <div class="chat chat-#{if message_data["user_id"] == user_id, do: "end", else: "start"}">
      <div class="chat-bubble">
        #{message_data["content"]}
      </div>
    </div>
    """
  end
end
