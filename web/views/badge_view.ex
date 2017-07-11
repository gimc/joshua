defmodule Joshua.BadgeView do
  use Joshua.Web, :view

  def render("index.json", %{badges: badges}) do
    render_many(badges, Joshua.BadgeView, "badge.json")
  end

  def render("show.json", %{badge: badge}) do
    render_one(badge, Joshua.BadgeView, "badge.json")
  end

  def render("badge.json", %{badge: badge}) do
    %{id: badge.id,
      name: badge.name,
      description: badge.description,
      icon: badge.icon,
      count: badge.count,
      event_name: badge.event_name}
  end
end
