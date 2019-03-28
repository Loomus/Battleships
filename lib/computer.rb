require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './player'

class Computer
  attr_reader :computer_board, :player_board

  def initialize(computer_board, player_board)
    @computer_board = computer_board
    @player_board = player_board
    @sheila = Ship.new("Sheila", 3)
    @toto = Ship.new("Toto",  2)
    @comp_shots = []
  end

  def find_empty_cell
    coord = @computer_board.cells.find do |key, value|
      return key if value.empty?
    end
  end

  def setup_boards
    empty_cell = find_empty_cell
    place_comp_piece(empty_cell, @sheila)

    empty_cell = find_empty_cell
    place_comp_piece(empty_cell, @toto)
  end

  def place_comp_piece(empty_cell, ship)
    split_cell = empty_cell.split('').to_a
    coordinates = build_row(split_cell[0], split_cell[1].to_i, split_cell[1].to_i + ship.length) &&
     build_column(split_cell[1], split_cell[0].ord, split_cell[0].ord + ship.length)
    if @computer_board.valid_coordinates?(coordinates)
      @computer_board.place(ship, coordinates)
    end
  end

  def build_row(x_coord, y_index, y_max)
    coords = []
    while y_index < y_max
      coords << x_coord + y_index.to_s
      y_index += 1
    end
    return coords
  end

  def build_column(y_coord, x_index, x_max)
    coords = []
    while x_index < x_max
      coords << x_index.chr + y_coord
      x_index += 1
    end
    return coords
  end

  def computer_bombs_away
    coord = @player_board.cells.sample
    until @comp_shots.include?(coord) == false
      @player_board.cells.sample
    end
    coord.fire_upon
    @comp_shots << coord
  end
end
