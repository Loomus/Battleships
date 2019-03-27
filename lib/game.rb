require_relative './board'
require_relative './ship'
require_relative './cell'

class Game
  def initialize
    @player_board = Board.new
    @comp_board = Board.new
    @sheila = Ship.new("Sheila", 3)
    @toto = Ship.new("Toto",  2)
    @cells_taken = []
  end

  def main_menu
    p "Welcome to Battleship!"
    p "Enter p to play! Or q to quit."
    print "> "
    answer = gets.chomp
    if answer == "p"
      setup_boards
    else answer == "q"
      main_menu
    end
  end

  def find_empty_cell
    coord = @comp_board.cells.find do |key, value|
      return key if value.empty?
    end
  end

  def setup_boards
    # add @sheila
    empty_cell = find_empty_cell
    place_comp_piece(empty_cell, @sheila)

    # add @toto
    empty_cell = find_empty_cell
    place_comp_piece(empty_cell, @toto)
  end

  def place_comp_piece(empty_cell, ship)

    split_cell = empty_cell.split('').to_a
    coordinates = build_row(split_cell[0], split_cell[1].to_i, split_cell[1].to_i + ship.length)
    if @comp_board.valid_coordinates?(coordinates)
      @comp_board.place(ship, coordinates)
      return true
    else
      coordinates = build_column(split_cell[1], split_cell[0].ord, split_cell[0].ord + ship.length)
      if @comp_board.valid_coordinates?(coordinates)
        @comp_board.place(ship, coordinates)
        return true
      end
    end
    return false
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



  require 'pry'; binding.pry
    # build_row(x_coord, y_index, max)
    #
    #
    # @comp_board.place(@sheila, empty_cell)
    # @cells.keys.each_slice(4).to_a
    # @comp_board.render
    # @comp_board.cells.keys.sample = random_coord
    # until @comp_board.valid_placement? == true
    # "I have laid out my ships on the grid."
end
@game = Game.new
@game.main_menu
