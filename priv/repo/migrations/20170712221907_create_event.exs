defmodule Joshua.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
