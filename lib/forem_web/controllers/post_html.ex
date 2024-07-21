defmodule ForemWeb.PostHTML do
  use ForemWeb, :html

  alias ForemWeb.RoleHelpers

  embed_templates "post_html/*"

  @doc """
  Renders a post form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :current_user, :map, required: true

  def post_form(assigns)
end
