class Board
  attr_reader :cells

  def initialize
    @cells = {
     "A1" => Cell.new("A1"),
     "A2" => Cell.new("A2"),
     "A3" => Cell.new("A3"),
     "A4" => Cell.new("A4"),
     "B1" => Cell.new("B1"),
     "B2" => Cell.new("B2"),
     "B3" => Cell.new("B3"),
     "B4" => Cell.new("B4"),
     "C1" => Cell.new("C1"),
     "C2" => Cell.new("C2"),
     "C3" => Cell.new("C3"),
     "C4" => Cell.new("C4"),
     "D1" => Cell.new("D1"),
     "D2" => Cell.new("D2"),
     "D3" => Cell.new("D3"),
     "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_coordinates?(coordinates_array)
    coordinates_array.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
  end

  def length_equals_coord(ship, coordinate)
    ship.length == coordinate.count
  end

  def coordinates_split(ship, coordinate)
    coords_split = coordinate.flat_map do |coord|
      coord.split('').to_a
    end
  end

  def x_coords(ship, coordinate)
    split_coords = coordinates_split(ship, coordinate)
    nums = split_coords.reject do |coord|
      ["A", "B", "C", "D"].include?(coord)
    end
    int = nums.map do |num|
      num.to_i
    end
    int
  end

  def y_coords(ship, coordinate)
    split_coords = coordinates_split(ship, coordinate)
    abcd = split_coords.reject do |coord|
      ["1", "2", "3", "4"].include?(coord)
    end
    abcd
  end

  def consecutive_x_coords?(ship, coordinate)
    int_array = x_coords(ship, coordinate)
    int_array.each_cons(2).all? do |int_1, int_2|
      int_2 == int_1 + 1
    end
  end

  def y_ordinal_values(ship, coordinate)
    ord = y_coords(ship, coordinate)
    values = ord.map do |a|
      a.ord
    end
    values
  end

  def consecutive_y_coords?(ship, coordinate)
    abc = y_ordinal_values(ship, coordinate)
    abc.each_cons(2).all? do |a, b|
      b == a + 1
    end
  end

  def diagonal_coords?(ship, coordinate)
    cons_x = consecutive_x_coords?(ship, coordinate)
    cons_y = consecutive_y_coords?(ship, coordinate)
    (cons_x ^ cons_y)
  end

  def valid_placement?(ship, coordinate)
    length = length_equals_coord(ship, coordinate)
    valid_c = valid_coordinates?(coordinate)
    diag_c = diagonal_coords?(ship, coordinate)
    length && valid_c && diag_c
  end

  def place(ship, coordinate)
    coordinate.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end
end
