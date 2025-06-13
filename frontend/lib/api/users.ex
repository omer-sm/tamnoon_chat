defmodule Frontend.Api.Users do
  import Frontend.Api.Config

  def try_login(username, password) do
    # :crypto.hash(:sha256, password)
    password_hash = password

    case Req.post("#{backend()}/users/login",
           json: %{username: username, password_hash: password_hash}
         ) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Req.Response{status: status}} when status in [400, 401] ->
        {:error, :invalid_credentials}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
