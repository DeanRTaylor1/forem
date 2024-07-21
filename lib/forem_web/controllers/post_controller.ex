defmodule ForemWeb.PostController do
  use ForemWeb, :controller

  alias Forem.Posts
  alias Forem.Posts.Post
  alias Forem.Communities
  alias ForemWeb.RoleHelpers

  plug :only_creator when action in [:edit, :update]
  plug :admin_or_creator when action in [:delete]

  def index(conn, %{"community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    posts = Posts.list_posts(community)
    render(conn, :index, posts: posts, community: community)
  end

  def new(conn, %{"community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    changeset = Posts.change_post(%Post{})
    render(conn, :new, changeset: changeset, community: community)
  end

  def create(conn, %{"post" => post_params, "community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    post_params = Map.put(post_params, "community_id", community_id)
    post_params = Map.put(post_params, "user_id", conn.assigns.current_user.id)

    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/communities/#{community_id}/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, community: community)
    end
  end

  def show(conn, %{"id" => id, "community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    post = Posts.get_post!(id)
    render(conn, :show, post: post, community: community)
  end

  def edit(conn, %{"id" => id, "community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    post = Posts.get_post!(id)
    changeset = Posts.change_post(post)
    render(conn, :edit, post: post, changeset: changeset, community: community)
  end

  def update(conn, %{"id" => id, "post" => post_params, "community_id" => community_id}) do
    community = Communities.get_community!(community_id)
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: ~p"/communities/#{community_id}/posts/#{post}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, post: post, changeset: changeset, community: community)
    end
  end

  def delete(conn, %{"id" => id, "community_id" => community_id}) do
    community = Communities.get_community!(community_id)

    if community == nil do
      conn
      |> put_flash(:error, "Community not found.")
    end

    post = Posts.get_post!(id)
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: ~p"/communities/#{community_id}/posts")
  end

  defp only_creator(conn, _opts) do
    current_user = conn.assigns[:current_user]
    post_id = conn.params["id"]
    post = Posts.get_post!(post_id)

    if RoleHelpers.is_creator(current_user, post) do
      conn
    else
      deny_access(conn, post)
    end
  end

  defp admin_or_creator(conn, _opts) do
    current_user = conn.assigns[:current_user]
    post_id = conn.params["id"]
    post = Posts.get_post!(post_id)

    if RoleHelpers.is_creator(current_user, post) || RoleHelpers.is_admin(current_user) do
      conn
    else
      deny_access(conn, post)
    end
  end

  defp deny_access(conn, post) do
    conn
    |> put_flash(:error, "You do not have permission to perform this action.")
    |> redirect(to: ~p"/communities/#{post.community_id}/posts")
    |> halt()
  end
end
