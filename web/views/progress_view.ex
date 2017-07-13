defmodule Joshua.ProgressView do
  use Joshua.Web, :view

  def render("show.json", %{progress: progress}) do
    %{data: render_many(progress, Joshua.ProgressView, "progress.json")}
  end

  def render("progress.json", %{progress: progress}) do
    %{name: progress.name,
      count: progress.count,
      required: progress.required,
      achieved: progress.achieved}
  end
end
