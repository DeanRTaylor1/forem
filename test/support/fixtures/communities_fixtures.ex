defmodule Forem.CommunitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forem.Communities` context.
  """

  @doc """
  Generate a community.
  """
  def community_fixture(attrs \\ %{}) do
    {:ok, community} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Forem.Communities.create_community()

    community
  end
end
