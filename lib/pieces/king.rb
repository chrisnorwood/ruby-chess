require_relative '../piece'

class King < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'K'
    @move_vectors = [[0,1], [0,-1], [1,0], [-1,0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end
end