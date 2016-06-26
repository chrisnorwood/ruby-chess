require_relative '../piece.rb'

class Pawn < Piece
  def intitialize
    super(color, position)
  end
end