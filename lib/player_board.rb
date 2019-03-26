require_relative './board'

class Player_board
  attr_reader :my_board,
              :comp_board

  def initialize(my_board, comp_board)
    @my_board   = Board.new(true)
    @comp_board = comp_board
  end

  def show_boards
    board = Board.new
    p board.render
  end
end
