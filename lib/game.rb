require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './computer'
require_relative './player'

class Game
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer = Computer.new(@computer_board, @player_board)
    @player = Player.new(@player_board, @computer_board)
    @sheila = Ship.new("Sheila", 3)
    @margot = Ship.new("Margot",  2)
    @leslie = Ship.new("Leslie", 3)
    @mildred = Ship.new("Mildred", 2)
    @cells_taken = []
  end

  def main_menu
    p "Welcome to Battleship!"
    p "Enter p to play! Or q to quit."
    print "> "
    answer = gets.chomp
    if answer == "p"
      setup_the_game
    else answer == "q"
      main_menu
    end
  end

  def setup_the_game
    @computer.setup_boards
    @player.show_board
    # require 'pry'; binding.pry
    @player.place_ships
    # @player.place_ships(@toto, @coordinate)
    # @player_board.render(true)
  end
end
@game = Game.new
p @game.main_menu
p @game.setup_the_game
