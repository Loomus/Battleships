require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_it_has_health
    assert_equal 3, @cruiser.health
  end

  def test_it_starts_as_not_sunk
    assert_equal false, @cruiser.sunk?
  end

  def test_hit_method_decreases_health
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_hit_method_can_decrease_multiple_times
    @cruiser.hit
    @cruiser.hit
    assert_equal 1, @cruiser.health
  end

  def test_if_cruiser_is_now_sunk
    @cruiser.hit
    @cruiser.hit
    assert_equal false, @cruiser.sunk?
  end

  def test_if_cruiser_is_finally_sunk
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
