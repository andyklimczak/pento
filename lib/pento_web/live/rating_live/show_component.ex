defmodule PentoWeb.RatingLive.ShowComponent do
  use PentoWeb, :live_component

  def render_rating_stars(stars) do
    filled_stars(stars)
    |> Enum.concat(unfilled_stars(stars))
    |> Enum.join(" ")
  end

  def filled_stars(stars) do
    List.duplicate("X", stars)
  end

  def unfilled_stars(stars) do
    List.duplicate("O", 5 - stars)
  end
end