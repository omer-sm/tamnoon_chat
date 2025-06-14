defmodule Frontend.Api.Rooms do
  import Frontend.Api.Config

  def get_rooms do
    case Req.get("#{backend()}/rooms") do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Req.Response{status: status}} when status in [400, 404] ->
        {:error, :not_found}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
