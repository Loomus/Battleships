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
    @cells.keys.include?(coordinate)
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
end
