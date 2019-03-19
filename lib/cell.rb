class Cell
  attr_reader :coordinate, :ship, :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(ship_type)
    @ship = ship_type
    @empty = false
  end
end