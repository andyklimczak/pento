defmodule PentoWeb.Pento.Canvas do
  use Surface.Component

  @width 10
  slot default, required: true

  prop viewBox, :string

  def render(assigns) do
    ~H"""
    <svg viewBox="{{ @viewBox }}">
      <defs>
        <rect id="point" width="10" height="10"/>
      </defs>
      <slot/>
    </svg>
    """
  end
end