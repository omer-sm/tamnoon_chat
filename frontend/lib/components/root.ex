defmodule Frontend.Components.Root do
  @behaviour Tamnoon.Component

  @impl true
  def heex do
    ~s"""
    <!DOCTYPE html>
    <html lang="en" class="bg-base-200" data-theme="dark" style="scrollbar-width: none;">

      <head>
        <meta name="description" content="Webpage description goes here" />
        <meta charset="utf-8">
        <title>Tamnoon Chat</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="ws_connect.js"></script>

        <!-- Include Tailwind CSS and DaisyUI -->
        <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
      </head>

      <body>
          <%= r.(Frontend.Components.LoginModal) %>
          <%= r.("chat_page.html.heex") %>
      </body>
    </html>
    """
  end
end
