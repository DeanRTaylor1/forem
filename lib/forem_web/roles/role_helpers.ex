defmodule ForemWeb.RoleHelpers do
  alias Forem.Accounts.User
  alias Forem.Posts.Post

  @doc """
  Checks if the user has an admin role.
  """
  def is_admin(%User{role: :admin}), do: true
  def is_admin(_), do: false

  @doc """
  Checks if the user has a moderator role.
  """
  def is_moderator(%User{role: :moderator}), do: true
  def is_moderator(%User{role: :admin}), do: true
  def is_moderator(_), do: false

  @doc """
  Checks if the user is the creator of the post.
  """
  def is_creator(%User{id: user_id}, %Post{user_id: post_user_id}) when user_id == post_user_id,
    do: true

  def is_creator(_, _), do: false

  @doc """
  Checks if the user can edit the post (only the creator).
  """
  def can_edit?(user, post), do: is_creator(user, post)

  @doc """
  Checks if the user can delete the post (creator or admin).
  """
  def can_delete?(user, post), do: is_creator(user, post) || is_admin(user)
end
