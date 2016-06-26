class Piece
  attr_accessor :color, :position, :symbol, :child_positions

  def initialize(color, position)
    @color = color
    @position = position
  end
end