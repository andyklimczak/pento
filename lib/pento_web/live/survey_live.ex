defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias __MODULE__.Component
  alias Pento.Survey
  alias PentoWeb.DemographicLive

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign_demographic
    }
  end

  def mount_current_user(session, socket) do
    case session do
      %{"user_token" => user_token} ->
        Phoenix.Component.assign_new(socket, :current_user, fn ->
          Accounts.get_user_by_session_token(user_token)
        end)
      %{} ->
        Phoenix.Component.assign_new(socket, :current_user, fn -> nil end)
    end
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end
end
