defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Guess a number.", number: Enum.random(1..10))}
  end

  def render(assigns) do
    ~L"""
      <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
      </h2>
      <h2>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
        <% end %>
      </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}=data, socket) do
    IO.inspect(socket.assigns)
    cond do
      socket.assigns.number == String.to_integer(guess) ->
        message = "Your guess: #{guess}. Correct! Guess again."
        score = socket.assigns.score + 10
        {:noreply, assign(socket, message: message, score: score, number: Enum.random(1..10))}
      true ->
        IO.inspect(data)
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {:noreply, assign(socket, message: message, score: score)}
    end
  end
end