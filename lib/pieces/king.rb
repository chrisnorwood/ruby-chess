require_relative '../piece'

class King < Piece
  def intitialize
    super(color, position)
  end
end