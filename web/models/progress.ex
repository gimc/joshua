defmodule Joshua.Progress do
  use Joshua.Web, :model

  alias Joshua.Badge
  alias Joshua.Event
  alias Joshua.Repo

  defstruct [:name, :count, :required, :achieved]

  @type t :: %__MODULE__{
    name: String.t(),
    count: integer,
    required: integer,
    achieved: boolean
  }

  def by_user_id(user_id) do
    badges = Repo.all(Badge)
    user_event_query = from e in Event, where: e.user_id == ^user_id
    user_events = Repo.all(user_event_query)
    Badge.progress(badges, user_events)
  end

end
