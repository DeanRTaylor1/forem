defmodule ForemWeb.RoleHelpers do
  alias Forem.Accounts.User

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
end
