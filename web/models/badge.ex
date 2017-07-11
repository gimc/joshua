defmodule Joshua.Badge do
  use Joshua.Web, :model

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
end
