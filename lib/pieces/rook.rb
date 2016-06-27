require_relative '../piece'

class Rook < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'R'
  end
end