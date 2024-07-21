defmodule Forem.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forem.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        title: "some title"
      })
      |> Forem.Posts.create_post()

    post
  end
end
