defmodule Joshua.BadgeControllerTest do
  use Joshua.ConnCase

  alias Joshua.Badge
  @valid_attrs %{
    count: 42,
    description: "some content",
    event_name: "some content",
    icon: "some content",
    name: "some content"
  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, badge_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    badge = Repo.insert! %Badge{}
    conn = get conn, badge_path(conn, :show, badge)
    assert json_response(conn, 200) == %{"id" => badge.id,
      "name" => badge.name,
      "description" => badge.description,
      "icon" => badge.icon,
      "count" => badge.count,
      "event_name" => badge.event_name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, badge_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, badge_path(conn, :create), @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Badge, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, badge_path(conn, :create), badge: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    badge = Repo.insert! %Badge{}
    conn = put conn, badge_path(conn, :update, badge), badge: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Badge, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    badge = Repo.insert! %Badge{}
    conn = put conn, badge_path(conn, :update, badge), badge: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    badge = Repo.insert! %Badge{}
    conn = delete conn, badge_path(conn, :delete, badge)
    assert response(conn, 204)
    refute Repo.get(Badge, badge.id)
  end
end
