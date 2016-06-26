require_relative '../piece.rb'

class Rook < Piece
  def intitialize
    super(color, position)
  end
end