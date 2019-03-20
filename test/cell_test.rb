require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
    @cruiser_2 = Ship.new("Cruiser", 3)
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

  def test_it_returns_a_dot_when_not_fired_upon
    assert_equal ".", @cell.render
  end

  def test_it_returns_an_M_when_shot_is_a_miss
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_it_returns_an_H_when_shot_is_a_hit
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end

  def test_it_returns_an_X_when_sunk
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    @cell.fire_upon
    @cell.fire_upon
    assert_equal "X", @cell.render
  end

  def test_it_returns_an_S_when_arg_is_true
    @cell_2.place_ship(@cruiser_2)
    assert_equal "S", @cell_2.render(true)
  end

  def test_cell_and_ship_methods_interacting_correctly
    @cell_2.place_ship(@cruiser_2)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render
    assert_equal false, @cruiser_2.sunk?
    @cruiser_2.hit
    @cruiser_2.hit
    assert_equal true, @cruiser_2.sunk?
    assert_equal "X", @cell_2.render
  end
end
