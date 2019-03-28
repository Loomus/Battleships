require_relative './board'
require_relative './ship'
require_relative './cell'
require_relative './computer'

class Player
  attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @margot = Ship.new("Margot", 2)
    @sheila = Ship.new("Sheila", 3)
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
    coords = gets.chomp.upcase
    until @player_board.valid_placement?(@margot, coords) == true
      puts "Those are invalid coordinates. Please try again:\n"
      puts "> "
      coords = gets.chomp.upcase.to_a
    end
      @player_board.place(@margot, coords)
    puts "Enter the squares for Sheila (3 spaces)\n"
    puts "> "
    coords_2 = gets.chomp.upcase.to_a
    until @player_board.valid_placement?(@sheila, coords_2) == true
      puts "Those are invalid coordinates. Please try again:\n"
      puts "> "
      coords_2 = gets.chomp.upcase.to_a
    end
      @player_board.place(@sheila, coords_2)
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
