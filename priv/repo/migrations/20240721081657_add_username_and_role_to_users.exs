defmodule Forem.Repo.Migrations.AddUsernameAndRoleToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
      add :role, :integer, default: 0
    end

    create index(:users, [:role])
  end
end
