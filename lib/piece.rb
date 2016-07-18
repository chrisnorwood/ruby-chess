class Piece
  attr_accessor :color, :position, :icon

  def initialize(color, position)
    @color = color
    @position = position
  end
end