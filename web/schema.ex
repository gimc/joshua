defmodule Joshua.Schema do
  use Absinthe.Schema

  alias Joshua.Repo
  alias Joshua.Badge

  object :badge do
    field :id, :id
    field :name, :string
    field :description, :string
    field :icon, :string
    field :count, :integer
    field :event_name, :string
  end

  query do
    @desc "Get all badges"
    field :badges, list_of(:badge) do
      resolve fn _, _ ->
        {:ok, Repo.all(Badge)}
      end
    end
  end
end
