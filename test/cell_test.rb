require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_returns_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_it_starts_without_ship
    assert_nil @cell.ship
  end

  def test_it_starts_cell_as_empty
    assert_equal true, @cell.empty?
  end

  def test_it_places_ship_in_cell
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_it_returns_cell_as_full_now
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end

  def test_ship_being_fired_upon_returns_false
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
  end

  def test_ship_can_be_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
  end

  def test_if_fired_upon_changes_to_true
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end
end
