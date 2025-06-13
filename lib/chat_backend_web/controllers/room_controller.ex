defmodule ChatBackendWeb.RoomController do
  use ChatBackendWeb, :controller

  alias ChatBackend.Rooms
  alias ChatBackend.Rooms.Room
  alias ChatBackend.Messages

  action_fallback ChatBackendWeb.FallbackController

  def index(conn, _params) do
    rooms = Rooms.list_rooms()
    render(conn, :index, rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Rooms.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/rooms/#{room}")
      |> render(:show, room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    render(conn, :show, room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{} = room} <- Rooms.update_room(room, room_params) do
      render(conn, :show, room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{}} <- Rooms.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end

  def messages(conn, %{"id" => id}) do
    messages = Messages.list_messages_by_room(id)

    conn
    |> put_view(ChatBackendWeb.MessageJSON)
    |> render(:index, messages: messages)
  end
end
