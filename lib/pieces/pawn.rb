require_relative '../piece'

class Pawn < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'P'
  end
end