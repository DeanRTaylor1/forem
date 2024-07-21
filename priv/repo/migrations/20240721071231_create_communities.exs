defmodule Forem.Repo.Migrations.CreateCommunities do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
