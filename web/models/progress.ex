defmodule Joshua.Progress do
  use Joshua.Web, :model

  alias Joshua.Badge
  alias Joshua.Event
  alias Joshua.Repo

  defstruct [:name, :count, :required, :date_achieved]

  @type t :: %__MODULE__{
    name: String.t(),
    count: integer,
    required: integer,
    date_achieved: NaiveDateTime.t()
  }

  def by_user_id(user_id) do
    badges = Repo.all(Badge)
    Badge.progress(badges, Event.user_events(user_id))
  end

end
