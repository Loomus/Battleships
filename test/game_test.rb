require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

class Gametest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_setup_board_function
    expected = "  1 2 3 4 \n" +
               " A S S S . \n" +
               " B . . . . \n" +
               " C . . . . \n" +
               " D . . . . \n"
    assert_equal expected, @game.setup_boards
  end

  def test_find_empty_cell
    assert_equal "A1", @game.find_empty_cell
  end
  # def test_can_place_random_horizontal_ship
  #
  #   assert_equal
  # end
end
