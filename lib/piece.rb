class Piece
  attr_accessor :color, :position, :icon, :child_positions

  def initialize(color, position)
    @color = color
    @position = position
  end
end