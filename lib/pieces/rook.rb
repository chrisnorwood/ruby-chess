require_relative '../piece'

class Rook < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'R'
    @jumper = false
    create_vectors
  end

  private

  def create_vectors
    create_horizontal_vectors
    create_vertical_vectors
  end
end