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
    aggregated_events =
      events
      |> Enum.reduce(%{}, fn (event, acc) ->
        Map.update(acc, event.name, 1, &(&1 + 1))
      end)

    badges
    |> Enum.map(fn (badge) ->
      count = aggregated_events[badge.event_name]
      %Progress{
        name: badge.name,
        count: min(count, badge.count),
        required: badge.count,
        achieved: count >= badge.count
      }
    end)
  end
end
