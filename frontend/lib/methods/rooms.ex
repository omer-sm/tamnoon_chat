defmodule Frontend.Methods.Rooms do
  alias Frontend.Api
  import Tamnoon.MethodManager

  defmethod :get_rooms do
    case Api.Rooms.get_rooms() do
      {:ok, rooms} ->
        rooms_html =
          Tamnoon.Compiler.render_component(
            Frontend.Components.Chat.RoomList,
            %{rooms: rooms["data"]},
            true
          )

        diff(%{rooms_html: rooms_html}, state)

      {:error, reason} ->
        diff(%{rooms_html: "", error: reason}, state)
    end
  end

  defmethod :switch_room do
    target_room_id = req["val"]

    case Api.Rooms.get_room(target_room_id) do
      {:ok, %{"data" => room}} ->
        trigger_method(:get_room_messages, %{"val" => room["id"]})

        diffs = %{
          current_room_id: room["id"],
          current_room_name: room["name"],
          current_message: "",
        }

        diff(diffs, state)

      {:error, reason} ->
        diff(%{error: reason}, state)
    end
  end

  defmethod :get_room_messages do
    room_id = req["val"]

    case Api.Rooms.get_room_messages(room_id) do
      {:ok, messages} ->
        messages_html =
          Tamnoon.Compiler.render_component(
            Frontend.Components.Chat.MessageList,
            %{messages: messages["data"], user_id: state[:user_id]},
            true
          )

        diff(%{messages_html: messages_html, messages: messages["data"]}, state)

      {:error, reason} ->
        diff(%{error: reason}, state)
    end
  end
end
