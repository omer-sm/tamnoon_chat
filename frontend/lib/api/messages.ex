defmodule Frontend.Api.Messages do
  import Frontend.Api.Config

  @spec send_message(%{content: String.t(), room_id: String.t(), user_id: String.t()}) ::
          {:ok, map()} | {:error, :not_found | any()}
  def send_message(message_data) do
    case Req.post("#{backend()}/messages",
                 json: %{message: message_data}) do
      {:ok, %Req.Response{status: 201, body: body}} ->
        {:ok, body}

      {:ok, %Req.Response{status: status}} when status in [400, 404] ->
        {:error, :not_found}

      {:error, reason} ->
        {:error, reason}
    end
  end

end
