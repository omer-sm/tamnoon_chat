defmodule Frontend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Frontend.Worker.start_link(arg)
      # {Frontend.Worker, arg}
      {Tamnoon,
       [
         [
           router: Frontend.Router,
           initial_state: %{
             logged_in: false,
             username: "",
             password: "",
             login_modal_class: "modal modal-open tmnn-login_modal_class-class"
           },
           methods_modules: [
             Frontend.Methods.Login
           ],
           debug_mode: true
         ]
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Frontend.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
