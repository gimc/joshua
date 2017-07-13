defmodule Joshua.ProgressControllerTest do
  use Joshua.ConnCase

  alias Joshua.Badge
  alias Joshua.Event

  @badges [
    %Badge{name: "1 item added", description: "Items added", icon: "item.jpg", count: 1, event_name: "add_item"},
    %Badge{name: "5 items added", description: "Items added", icon: "item.jpg", count: 5, event_name: "add_item"}
  ]

  @add_item_event %Event{
    name: "add_item",
    user_id: 1
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen resource", %{conn: conn} do
    Enum.each(@badges, &(Repo.insert!(&1)))
    Repo.insert!(@add_item_event)
    Repo.insert!(@add_item_event)

    conn = get conn, progress_path(conn, :show, 1)
    assert json_response(conn, 200)["data"] == [%{
      "name" => "1 item added",
      "count" => 1,
      "required" => 1,
      "achieved" => true
    }, %{
      "name" => "5 items added",
      "count" => 2,
      "required" => 5,
      "achieved" => false
    }]
  end

  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, progress_path(conn, :show, -1)
  #   end
  # end
end
