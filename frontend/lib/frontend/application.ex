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
           initial_state: fn ->
             %{
               logged_in: false,
               user_id: nil,
               username: "",
               password: "",
               login_modal_class: "modal modal-open tmnn-login_modal_class-class",
               login_invalid: false,
               current_room_id: nil,
               current_room_name: "Choose Room",
               rooms_html:
                 Frontend.Methods.Rooms.tmnn_get_rooms(%{}, %{})
                 |> elem(1)
                 |> Map.get(:rooms_html),
               messages: [],
               messages_html: "",
               current_message: ""
             }
           end,
           methods_modules: [
             Frontend.Methods.Login,
             Frontend.Methods.Rooms,
             Frontend.Methods.Messages
           ],
           debug_mode: false
         ]
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Frontend.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
