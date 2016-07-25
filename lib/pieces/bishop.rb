require_relative '../piece'

class Bishop < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'B'
    @jumper = false
    create_diagonal_vectors
  end
end