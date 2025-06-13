defmodule Frontend.Components.LoginModal do
  @behaviour Tamnoon.Component

  @impl true
  def heex() do
    ~S"""
    <dialog id="login_modal" class="modal modal-open">
      <div class="modal-box">
        <h3 class="text-lg font-bold">Login</h3>
        <p class="py-4">Please enter your credentials to log in.</p>

        <fieldset class="fieldset">
          <legend class="fieldset-legend">Username</legend>
          <input type="text" class="input w-100" onchange=@update-username value=@username />
        </fieldset>

        <fieldset class="fieldset">
          <legend class="fieldset-legend">Password</legend>
          <input type="password" class="input w-100" onchange=@update-password value=@password />
        </fieldset>

        <div class="modal-action">
          <button class="btn btn-primary" onclick=@update-logged_in value="true">Login</button>
          <button class="btn">Cancel</button>
        </div>
      </div>
    </dialog>
    """
  end
end
