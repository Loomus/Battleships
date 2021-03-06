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
    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]
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

  def test_it_iterates_over_valid_coordinates_array
    assert_equal true, @board.valid_coordinates?(["A1", "A2", "A3"])
  end

  def test_if_coordinates_are_same_length_as_ship
    assert_equal false, @board.length_equals_coord(@cruiser, ["A1", "A2"])
    assert_equal false, @board.length_equals_coord(@submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_can_be_split
    assert_equal ["A", "1", "A", "2", "A", "3"], @board.coordinates_split(@cruiser, ["A1", "A2", "A3"])
    assert_equal ["B", "3", "B", "4"], @board.coordinates_split(@submarine, ["B3", "B4"])
  end

  def test_x_coords_are_integers
    assert_equal [1,2,3], @board.x_coords(@cruiser, ["A1", "A2", "A3"])
    assert_equal [1,2], @board.x_coords(@submarine, ["B1", "B2"])
  end

  def test_y_coords_are_letters
    assert_equal ["A", "A"], @board.y_coords(@submarine, ["A1", "A2"])
  end

  def test_consecutive_x_coords
    assert_equal true, @board.consecutive_x_coords?(@submarine, ["A1", "A2"])
    assert_equal false, @board.consecutive_x_coords?(@submarine, ["A1", "A3"])
  end

  def test_it_returns_y_ordinal_values
    assert_equal [65, 65], @board.y_ordinal_values(@submarine, ["A1", "A2"])
    assert_equal [65, 66], @board.y_ordinal_values(@submarine, ["A1", "B1"])
    assert_equal [66, 67], @board.y_ordinal_values(@submarine, ["B1", "C1"])
    assert_equal [67, 68], @board.y_ordinal_values(@submarine, ["C1", "D1"])
  end

  def test_consecutive_y_cords
    assert_equal true, @board.consecutive_y_coords?(@submarine, ["A1", "B1"])
    assert_equal false, @board.consecutive_y_coords?(@submarine, ["A1", "C1"])
  end


  def test_are_the_coordinates_valid_for_ship_placement
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_valid_placement_cannot_be_diagonal
    assert_equal false, @board.diagonal_coords?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.diagonal_coords?(@submarine, ["C2", "D3"])
  end

  def test_if_ship_can_be_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @cell_1.ship
    @cell_2.ship
    @cell_3.ship
    assert_equal true, @cell_3.ship == @cell_2.ship
  end


  def test_ships_cannot_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.overlapping_ships?(@submarine, ["A1", "B1"])
  end

  def test_it_creates_rows
    expected = [["A1", "A2", "A3", "A4"],
                ["B1", "B2", "B3", "B4"],
                ["C1", "C2", "C3", "C4"],
                ["D1", "D2", "D3", "D4"]]
    assert_equal expected, @board.rows_created
  end

  def test_it_creates_columns
    expected = [["A1", "B1", "C1", "D1"],
                ["A2", "B2", "C2", "D2"],
                ["A3", "B3", "C3", "D3"],
                ["A4", "B4", "C4", "D4"]]
    assert_equal expected, @board.columns_created
  end

  def test_it_renders_the_board
    expected = "  1 2 3 4 \n" +
               " A . . . . \n" +
               " B . . . . \n" +
               " C . . . . \n" +
               " D . . . . \n"
    assert_equal expected, @board.render
  end

  def test_rendered_board_updates_after_ship_placed
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expected = "  1 2 3 4 \n" +
               " A S S S . \n" +
               " B . . . . \n" +
               " C . . . . \n" +
               " D . . . . \n"
    assert_equal expected, @board.render(true)
  end
end
