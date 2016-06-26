require_relative '../piece.rb'

class King < Piece
  def intitialize
    super(color, position)
  end
end