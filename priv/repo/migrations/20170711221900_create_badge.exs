defmodule Joshua.Repo.Migrations.CreateBadge do
  use Ecto.Migration

  def change do
    create table(:badges) do
      add :name, :string
      add :description, :string
      add :icon, :string
      add :count, :integer
      add :event_name, :string

      timestamps()
    end

  end
end
