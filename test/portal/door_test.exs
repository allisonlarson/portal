defmodule DoorTest do
  use ExUnit.Case, async: true
  doctest Portal.Door

  test "it can start a door with a color" do
    assert Portal.Door.start_link(:blue)
  end

  test "it can get an existing door by color" do
    Portal.Door.start_link(:blue)
    assert Portal.Door.get(:blue)
  end

  test "it can push a value into door" do
    Portal.Door.start_link(:blue)
    Portal.Door.push(:blue, 1)
    assert Portal.Door.get(:blue) == [1]
  end

  test "it can push multiple values into door" do
    Portal.Door.start_link(:blue)
    Portal.Door.push(:blue, 1)
    Portal.Door.push(:blue, 2)
    assert Portal.Door.get(:blue) == [2, 1]
  end

  test "it can pop value out of door" do
    Portal.Door.start_link(:blue)
    Portal.Door.push(:blue, 1)
    Portal.Door.push(:blue, 2)
    Portal.Door.pop(:blue)
    assert Portal.Door.get(:blue) == [1]
  end

  test "returns an empty set when popping empty door" do
    Portal.Door.start_link(:blue)
    assert :error == Portal.Door.pop(:blue)
    assert Portal.Door.get(:blue) == []
  end
end
