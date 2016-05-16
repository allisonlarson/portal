defmodule PortalTest do
  use ExUnit.Case, async: true
  doctest Portal

  test "it can shoot a portal" do
    assert Portal.shoot(:orange)
    assert Portal.Door.get(:orange)
  end

  test "it can transfer portals" do
    data = [1, 2]
    Portal.shoot(:orange)
    Portal.shoot(:red)

    assert Portal.transfer(:orange, :red, data)
    assert Portal.Door.get(:orange) == Enum.reverse(data)
    assert Portal.Door.get(:red) == []
  end

  test "it can push_right" do
    data = [1, 2]
    Portal.shoot(:yellow)
    Portal.shoot(:purple)

    portal = Portal.transfer(:yellow, :purple, data)
    Portal.push_right(portal)
    assert Portal.Door.get(:yellow) == [1]
    assert Portal.Door.get(:purple) == [2]
  end

  test "it can push_left" do
    data = [1, 2]
    Portal.shoot(:cyan)
    Portal.shoot(:magenta)

    portal = Portal.transfer(:cyan, :magenta, data)
    Portal.push_right(portal)
    Portal.push_right(portal)
    Portal.push_left(portal)
    assert Portal.Door.get(:cyan) == [1]
    assert Portal.Door.get(:magenta) == [2]
  end

  test "it doesn't error with empty push" do
    Portal.shoot(:black)
    Portal.shoot(:white)

    portal = Portal.transfer(:black, :white, [])
    assert Portal.push_right(portal)
  end
end
