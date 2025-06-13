defmodule Frontend.Components.LoginModal do
  @behaviour Tamnoon.Component

  @impl true
  def heex() do
    ~S"""
    <dialog id="login_modal" class=@login_modal_class>
      <div class="modal-box">
        <h3 class="text-lg font-bold text-center">Login</h3>

        <fieldset class="fieldset">
          <legend class="fieldset-legend">Username</legend>
          <input type="text" class="input w-full" onchange=@update-username value=@username />
        </fieldset>

        <fieldset class="fieldset">
          <legend class="fieldset-legend">Password</legend>
          <input type="password" class="input w-full" onchange=@update-password value=@password />
        </fieldset>

        <div class="modal-action">
          <button class="btn btn-primary w-50 mx-auto" onclick=@try_login>Login</button>
        </div>
      </div>
    </dialog>
    """
  end
end
