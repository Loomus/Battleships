class Player
  attr_reader :player_board

  def initialize(player_board)
    @player_board = Board.new
    @computer_board = computer_board
    @margot = Ship.new("Margot", 2)
    @sheila = Ship.new("Sheila", 3)
    @shots = []
  end

  def show_board
    " * PLAYER BOARD * \n" +
    @player_board.render(true)
  end

  def place_ships(ship, coordinate)
    "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "Margot, our cruiser, is 2 units long and Sheila, our steely submarine, is 3 units long.\n" +
    "  1 2 3 4\n" +
    "A . . . .\n" +
    "B . . . .\n" +
    "C . . . .\n" +
    "D . . . .\n" +
    "Enter the squares for Margot (3 spaces):\n" +
    "> "
    coords = gets.chomp.upcase.to_a
    until @player_board.valid_placement?(@margot, coords) == true
      "Those are invalid coordinates. Please try again:\n" +
      "> "
      coords = gets.chomp.upcase.to_a
    end
      @player_board.place(@margot, coords)
    @player_board.render
    "Enter the squares for Sheila (3 spaces)\n" +
    "> "
    coords_2 = gets.chomp.upcase.to_a
    until @player_board.valid_placement?(@sheila, coords_2) == true
      "Those are invalid coordinates. Please try again:\n" +
      "> "
      coords_2 = gets.chomp.upcase.to_a
    end
      @player_board.place(@sheila, coords_2)
    end
    @player_board.render
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
