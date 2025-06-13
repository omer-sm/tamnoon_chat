defmodule Frontend.Components.LoginModal do
  @behaviour Tamnoon.Component

  @impl true
  def heex() do
    ~S"""
    <dialog id="login_modal" class="modal modal-open" class=@login_modal_class>
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

        <%= Frontend.Components.LoginModal.error_alert() %>
      </div>
    </dialog>
    """
  end

  def error_alert() do
    ~S"""
    <div role="alert" class="alert alert-error mt-5" hidden hidden=@not-login_invalid>
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
      <span>Login failed, please try again.</span>
    </div>
    """
  end
end
