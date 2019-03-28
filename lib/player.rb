require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './computer'

class Player
  attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @margot = Ship.new("Margot", 3)
    @sheila = Ship.new("Sheila", 2)
    @shots = []
  end

  def show_board
    " * PLAYER BOARD * \n" +
    @player_board.render
  end

  def place_ships
    puts "I have laid out my ships on the grid.\n"
    puts "You now need to lay out your two ships.\n"
    puts "Margot, our cruiser, is 2 units long and Sheila, our steely submarine, is 3 units long.\n"
    puts "  1 2 3 4\n"
    puts "A . . . .\n"
    puts "B . . . .\n"
    puts "C . . . .\n"
    puts "D . . . .\n"
    puts "Enter the squares for Margot (3 spaces):\n"
    puts "> "
    coordinate = gets.chomp.upcase.split
    until @player_board.valid_placement?(@margot, coordinate) == true
      puts "Those are invalid coordinates. Please try again:\n"
      puts "> "
      coordinate = gets.chomp.upcase.split
    end
      @player_board.place(@margot, coordinate)
    puts "Enter the squares for Sheila (2 spaces)\n"
    puts "> "
    coordinate = gets.chomp.upcase.split
    until @player_board.valid_placement?(@sheila, coordinate) == true
      puts "Those are invalid coordinates. Please try again:\n"
      puts "> "
      coordinate = gets.chomp.upcase.split
    end
      @player_board.place(@sheila, coordinate)
      @player_board.render(true)
    end
  end

  def bombs_away
    "You're up! Where would you like to fire?"
    answer = gets.chomp.upcase
    until answer == @computer_board.valid_coordinate?(answer)
      "Please enter a valid coordinate"
      answer = gets.chomp.upcase
    end
    if @shots.include?(answer) == false
    @computer_board.cells[answer].fire_upon
    @shots << answer
  end
end
