defmodule PentoWeb.Pento.Colors do
  def color(c), do: color(c, false)

  def color(_color, true), do: "#B86EF0"
  def color(:green, _active), do: "#8BBF57"
  def color(:dark_green, _active), do: "#689042"
  def color(:light_green, _active), do: "#C1D6AC"
  def color(:orange, _active), do: "#B97328"
  def color(:dark_orange, _active), do: "#8D571E"
  def color(:light_orange, _active), do: "#F4CCA1"
  def color(:gray, _active), do: "#848386"
  def color(:dark_gray, _active), do: "#5A595A"
  def color(:light_gray, _active), do: "#B1B1B1"
  def color(:blue, _active), do: "#83C7CE"
  def color(:dark_blue, _active), do: "#63969B"
  def color(:light_blue, _active), do: "#B9D7DA"
  def color(:purple, _active), do: "#240054"
end