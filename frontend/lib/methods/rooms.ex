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
        diffs = %{
          current_room_id: room["id"],
          current_room_name: room["name"]
        }
        diff(diffs, state)

      {:error, reason} ->
        diff(%{error: reason}, state)
    end
  end
end
