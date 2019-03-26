require_relative './board'
require_relative './cell'
require_relative './ship'
require_relative './game'

  def setup
    @player_board = Board.new(true)
    @comp_board = Board.new
    @sheila = Ship.new("Sheila", 3)
    @toto = Ship.new("Toto",  2)
  end


game = Game.new
game.main_menu
game.setup_boards
