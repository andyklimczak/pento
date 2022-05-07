defmodule PentoWeb.Pento.GameLive do
  use Surface.LiveView

  alias PentoWeb.Pento.{Title, Palette}

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <section class="container">
    <Title message="Welcome to Pento!" />
    <Palette shapes_names={{ [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t] }}/>
    </section>
    """
  end
end