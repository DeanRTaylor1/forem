defmodule Forem.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :description, :string
    field :image, :string

    belongs_to :community, Forem.Communities.Community
    belongs_to :user, Forem.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :image, :community_id, :user_id])
    |> validate_required([:title, :description, :community_id, :user_id])
  end
end
