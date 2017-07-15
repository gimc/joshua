defmodule Joshua.ProgressController do
  use Joshua.Web, :controller

  alias Joshua.Progress

  def show(conn, %{"id" => user_id}) do
    render(conn, "show.json", progress: Progress.by_user_id(user_id))
  end
end
