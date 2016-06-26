require_relative '../piece'

class Pawn < Piece
  def intitialize
    super(color, position)
  end
end