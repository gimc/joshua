defmodule Joshua.EventView do
  use Joshua.Web, :view

  def render("index.json", %{events: events}) do
    %{data: render_many(events, Joshua.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, Joshua.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      user_id: event.user_id}
  end
end
