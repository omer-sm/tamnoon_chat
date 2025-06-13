defmodule Frontend.Methods.Login do
  import Tamnoon.MethodManager

  defmethod :try_login do
    %{
      username: username,
      password: password
    } = state

    # Here you would typically validate the username and password
    # For demonstration, we assume any non-empty credentials are valid
    if username != "" and password != "" do
      diff(
        %{login_modal_class: "modal tmnn-login_modal_class-class", logged_in: true, password: ""},
        state
      )
    else
      diff(%{login_invalid: true}, state)
    end
  end
end
