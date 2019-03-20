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
    if empty?
      @fired_upon = true
    else
      @fired_upon = true
      @ship.hit
    end
  end

  def render(arg=true)
    if empty? == false && ship.sunk? == true
      "X"
    elsif empty? == true && fired_upon?
      "M"
    elsif empty? == false && fired_upon? == true
      "H"
    elsif empty? == false && arg = true
      "S"
    else
      "."
    end
  end
end
