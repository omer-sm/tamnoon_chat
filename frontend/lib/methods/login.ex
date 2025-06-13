defmodule Frontend.Methods.Login do
  alias Frontend.Api
  import Tamnoon.MethodManager

  defmethod :try_login do
    %{
      username: username,
      password: password
    } = state

    login_result = Api.Users.try_login(username, password)

    if elem(login_result, 0) == :ok do
      diff(
        %{login_modal_class: "modal tmnn-login_modal_class-class", logged_in: true, password: ""},
        state
      )
    else
      diff(%{login_invalid: true}, state)
    end
  end
end
