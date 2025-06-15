defmodule Frontend.Methods.Messages do
  import Tamnoon.MethodManager
  alias Frontend.Api

  defmethod :send_message do
    %{
      current_message: current_message,
      current_room_id: current_room_id,
      user_id: user_id
    } = state

    message_data = %{
      content: current_message,
      room_id: current_room_id,
      user_id: user_id
    }

    case Api.Messages.send_message(message_data) do
      {:ok, response} ->
        trigger_method(:pub, %{
          "channel" => "room_#{current_room_id}",
          "action" => %{
            "method" => "add_message",
            "message" => response["data"]
          }
        })

        diff(%{current_message: ""}, state)

      {:error, reason} ->
        diff(%{error: reason}, state)
    end
  end

  defmethod :add_message do
    IO.inspect(req)
    new_messages = state[:messages] ++ [req["message"]]

    messages_html =
      Tamnoon.Compiler.render_component(
        Frontend.Components.Chat.MessageList,
        %{messages: new_messages, user_id: state[:user_id]},
        true
      )

    diff(%{messages_html: messages_html, messages: new_messages}, state)
  end
end
