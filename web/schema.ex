defmodule Joshua.Schema do
  use Absinthe.Schema

  alias Joshua.Repo
  alias Joshua.Badge
  alias Joshua.Progress

  object :badge do
    field :id, :id
    field :name, :string
    field :description, :string
    field :icon, :string
    field :count, :integer
    field :event_name, :string
  end

  object :progress do
    field :id, :id
    field :name, :string
    field :count, :integer
    field :required, :integer
    field :achieved, :boolean
  end

  query do
    @desc "Get all badges"
    field :badges, list_of(:badge) do
      resolve fn _, _ ->
        {:ok, Repo.all(Badge)}
      end
    end

    @desc "Get all progress for user"
    field :all_progress, list_of(:progress) do
      arg :user_id, non_null(:integer)
      resolve fn %{user_id: user_id}, _ ->
        {:ok, Progress.by_user_id(user_id)}
      end
    end
  end
end
