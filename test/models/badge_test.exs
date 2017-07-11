defmodule Joshua.BadgeTest do
  use Joshua.ModelCase

  alias Joshua.Badge

  @valid_attrs %{count: 42, description: "some content", event_name: "some content", icon: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Badge.changeset(%Badge{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Badge.changeset(%Badge{}, @invalid_attrs)
    refute changeset.valid?
  end
end
