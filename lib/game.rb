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

  def spot_select

  end

  def find_empty_cell
    coord = @comp_board.cells.find do |key, value|
      return key if value.empty?
    end
  end

  def setup_boards
    find_empty_cell
    require 'pry'; binding.pry
    @cells.keys.each_slice(4).to_a
    @comp_board.render
    @comp_board.cells.keys.sample(3) = random_coord
    until @comp_board.valid_placement? == true
    "I have laid out my ships on the grid."
  end
end
