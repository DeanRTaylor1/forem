defmodule ForemWeb.CommunityControllerTest do
  use ForemWeb.ConnCase

  import Forem.CommunitiesFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  describe "index" do
    test "lists all communities", %{conn: conn} do
      conn = get(conn, ~p"/communities")
      assert html_response(conn, 200) =~ "Listing Communities"
    end
  end

  describe "new community" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/communities/new")
      assert html_response(conn, 200) =~ "New Community"
    end
  end

  describe "create community" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/communities", community: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/communities/#{id}"

      conn = get(conn, ~p"/communities/#{id}")
      assert html_response(conn, 200) =~ "Community #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/communities", community: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Community"
    end
  end

  describe "edit community" do
    setup [:create_community]

    test "renders form for editing chosen community", %{conn: conn, community: community} do
      conn = get(conn, ~p"/communities/#{community}/edit")
      assert html_response(conn, 200) =~ "Edit Community"
    end
  end

  describe "update community" do
    setup [:create_community]

    test "redirects when data is valid", %{conn: conn, community: community} do
      conn = put(conn, ~p"/communities/#{community}", community: @update_attrs)
      assert redirected_to(conn) == ~p"/communities/#{community}"

      conn = get(conn, ~p"/communities/#{community}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, community: community} do
      conn = put(conn, ~p"/communities/#{community}", community: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Community"
    end
  end

  describe "delete community" do
    setup [:create_community]

    test "deletes chosen community", %{conn: conn, community: community} do
      conn = delete(conn, ~p"/communities/#{community}")
      assert redirected_to(conn) == ~p"/communities"

      assert_error_sent 404, fn ->
        get(conn, ~p"/communities/#{community}")
      end
    end
  end

  defp create_community(_) do
    community = community_fixture()
    %{community: community}
  end
end
