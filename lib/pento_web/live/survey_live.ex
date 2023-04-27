defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias __MODULE__.Component
  alias Pento.Survey
  alias Pento.Catalog
  alias PentoWeb.DemographicLive
  alias PentoWeb.RatingLive
  alias PentoWeb.Endpoint

  @survey_results_topic "survey_results"

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_demographic()
      |> assign_products()
    }
  end

  def mount_current_user(session, socket) do
    case session do
      %{"user_token" => user_token} ->
        Phoenix.Component.assign_new(
          socket,
          :current_user,
          fn ->
            Accounts.get_user_by_session_token(user_token)
          end
        )
      %{} ->
        Phoenix.Component.assign_new(socket, :current_user, fn -> nil end)
    end
  end

  defp assign_demographic(
         %{
           assigns: %{
             current_user: current_user
           }
         } = socket
       ) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "demographic created")
    |> assign(:demographic, demographic)
  end

  def assign_products(
        %{
          assigns: %{
            current_user: current_user
          }
        } = socket
      ) do
    assign(socket, :products, list_products(current_user))
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_rating_created(
        %{
          assigns: %{
            products: products
          }
        } = socket,
        updated_product,
        product_index
      ) do
    Endpoint.broadcast(@survey_results_topic, "rating_created", %{})
    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(:products, List.replace_at(products, product_index, updated_product))
  end
end