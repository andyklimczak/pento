defmodule PentoWeb.RatingLive.Index do
  use Phoenix.Component
  use Phoenix.HTML
  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Show

  attr :products, :list, required: true
  attr :current_user, :any, required: true

  def heading(assigns) do
    ~H"""
      <h2 class="font-medium text-2xl">
        Ratings <%= if ratings_complete?(@products), do: raw "&#x2713;" %>
      </h2>
    """
  end

  def product_list(assigns) do
    ~H"""
      <.heading products={@products} />
      <div class="grid grid-cols-2 gap-4 divide-y">
        <.product_rating
          :for={ {p, i} <- Enum.with_index(@products) }
          current_user={@current_user}
          product={p}
          index={1} />
      </div>
    """
  end

  defp ratings_complete?(products) do
    Enum.all?(products, fn product ->
      not Enum.empty?(product.ratings)
    end)
  end

  def product_rating(assigns) do
    ~H"""
      <div><%= @product.name %></div>
      <%= if rating = List.first(@product.ratings) do %>
        <Show.stars rating={rating} product={@product} />
      <% else %>
        <div>
          <.live_component module={RatingLive.Form}
            id={"rating-form-#{@product.id}"}
            product={@product}
            product_index={@index}
            current_user={@current_user} />
        </div>
      <% end %>
    """
  end
end
