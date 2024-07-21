defmodule ForemWeb.CommunityHTML do
  use ForemWeb, :html

  alias ForemWeb.RoleHelpers

  embed_templates "community_html/*"

  @doc """
  Renders a community form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :current_user, :map, required: true

  def community_form(assigns)
end
