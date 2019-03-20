class Cell
  attr_reader :coordinate,
              :ship,
              :empty,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship_type)
    @ship = ship_type
    @empty = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    ship.hit
    @fired_upon = true 
  end
end
