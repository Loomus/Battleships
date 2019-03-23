require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test

  def setup
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
    @board = Board.new
    # require 'pry'; binding.pry
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_how_keys_are_in_cell_hash
    assert_equal 16, @board.cells.keys.count
  end

  def test_if_validates_cordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_if_coordinates_are_same_length_as_ship
    assert_equal false, @board.length_equals_coord(@cruiser, ["A1", "A2"])
    assert_equal false, @board.length_equals_coord(@submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_can_be_split
    assert_equal ["A", "1", "A", "2"], @board.coordinates_split(@cruiser, ["A1", "A2"])
  end

  def test_x_coords_are_integers
    assert_equal [1,2], @board.x_coords(@cruiser, ["A1", "A2"])
  end

  def test_y_coords_are_letters
    assert_equal ["A", "A"], @board.y_coords(@cruiser, ["A1", "A2"])
  end 

  # def test_are_coordinates_consecutive
  #   assert_equal false, @board.consecutive_coord(@cruiser, ["A1", "A2", "A4"])
  #   assert_equal false, @board.consecutive_coord(@submarine, ["A1", "C1"])
  #   assert_equal false, @board.consecutive_coord(@cruiser, ["A3", "A2", "A1"])
  #   assert_equal false, @board.consecutive_coord(@submarine, ["C1", "B1"])
  # end
end
