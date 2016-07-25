require_relative '../piece'

class Knight < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'N'
    @jumper = true
    @move_vectors = [[1,2], [-1,2], [1,-2], [-1,-2], [2,1], [-2,1], [2,-1], [-2,-1]]
  end
end