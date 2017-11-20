defmodule Joshua.Badge do
  use Joshua.Web, :model

  alias Joshua.Event
  alias Joshua.Progress

  @type t :: %__MODULE__{
    name: String.t(),
    description: String.t(),
    icon: String.t(),
    count: integer,
    event_name: String.t()
  }

  schema "badges" do
    field :name, :string
    field :description, :string
    field :icon, :string
    field :count, :integer
    field :event_name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :icon, :count, :event_name])
    |> validate_required([:name, :description, :icon, :count, :event_name])
  end

  @spec progress(badges :: [Badge.t()], events :: [Event.t()]) :: [Progress.t()]
  def progress(badges, events) do
    events_by_date = Enum.sort(events, &(NaiveDateTime.compare(&1.inserted_at, &2.inserted_at) != :gt))

    badges
    |> Enum.map(fn (badge) ->
      {num_events, date_achieved} = reduce_event_list(badge, events_by_date)

      %Progress{
        name: badge.name,
        count: num_events,
        required: badge.count,
        date_achieved: date_achieved
      }
    end)
  end

  def reduce_event_list(_badge, []), do: {0, nil}
  def reduce_event_list(badge, events) do
    events
    |> Enum.filter(&(&1.name == badge.event_name))
    |> Enum.reduce_while({1, nil}, fn event, {num_events, _date} ->
      if num_events == badge.count, do: {:halt, {num_events, event.inserted_at}}, else: {:cont, {num_events + 1, nil}}
    end)
end

end
