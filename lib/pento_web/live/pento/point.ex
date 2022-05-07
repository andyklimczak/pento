defmodule PentoWeb.Pento.Point do
  use Surface.Component

  @width 10

  prop x, :integer
  prop y, :integer
  prop fill, :string
  prop name, :string

  def render(assigns) do
    ~H"""
      <use xlink:href="#point" x="{{ convert(@x) }}" y="{{ convert(@y) }}" fill="{{ @fill }}" />
    """
  end

  defp convert(i) do
    (String.to_integer(i) - 1) * @width + 2 * @width
  end
end