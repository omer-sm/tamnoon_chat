defmodule ChatBackendWeb.MessageJSON do
  alias ChatBackend.Messages.Message

  @doc """
  Renders a list of messages.
  """
  def index(%{messages: messages}) do
    %{data: for(message <- messages, do: data(message))}
  end

  @doc """
  Renders a single message.
  """
  def show(%{message: message}) do
    %{data: data(message)}
  end

  defp data(%Message{} = message) do
    %{
      id: message.id,
      content: message.content,
      user_id: message.user_id,
      room_id: message.room_id,
      created_at: message.inserted_at,
      sender_name: (message.user && message.user.username)
    }
  end
end
