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
    {:ok, message_time, _} = DateTime.from_iso8601(message_data["created_at"])
    now = DateTime.now!("Etc/UTC")
    is_today =
      message_time.year == now.year and
      message_time.month == now.month and
      message_time.day == now.day

    message_time_formatted =
      if is_today do
        # Format as HH:mm
        "#{pad2(message_time.hour)}:#{pad2(message_time.minute)}"
      else
        # Format as yy/MM/dd HH:mm
        "#{rem(message_time.year, 100) |> pad2()}/#{pad2(message_time.month)}/#{pad2(message_time.day)} #{pad2(message_time.hour)}:#{pad2(message_time.minute)}"
      end

    ~s"""
    <div class="chat chat-#{if message_data["user_id"] == user_id, do: "end", else: "start"}">
      <div class="chat-header text-sm">
        #{if message_data["user_id"] == user_id, do: "You", else: message_data["sender_name"]}
        <time class="text-sm opacity-50">#{message_time_formatted}</time>
      </div>
      <div class="chat-bubble">
        #{message_data["content"]}
      </div>
    </div>
    """
  end

  defp pad2(n) when is_integer(n) and n < 10, do: "0#{n}"
  defp pad2(n), do: "#{n}"
end
