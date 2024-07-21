defmodule Forem.Communities.Community do
  use Ecto.Schema
  import Ecto.Changeset

  schema "communities" do
    field :name, :string
    field :description, :string

    has_many :posts, Forem.Posts.Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(community, attrs) do
    community
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
