defmodule Joshua.Event do
  use Joshua.Web, :model

  alias Joshua.Repo

  @type t :: %__MODULE__{
    name: String.t(),
    user_id: integer
  }

  schema "events" do
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end

  def user_events(user_id) do
    user_event_query = from e in __MODULE__, where: e.user_id == ^user_id
    Repo.all(user_event_query)
  end
end
