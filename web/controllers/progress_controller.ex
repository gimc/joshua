defmodule Joshua.ProgressController do
  use Joshua.Web, :controller

  alias Joshua.Badge
  alias Joshua.Event

  def show(conn, %{"id" => user_id}) do
    badges = Repo.all(Badge)
    user_event_query = from e in Event, where: e.user_id == ^user_id
    user_events = Repo.all(user_event_query)
    progress = Badge.progress(badges, user_events)
    render(conn, "show.json", progress: progress)
  end
end
