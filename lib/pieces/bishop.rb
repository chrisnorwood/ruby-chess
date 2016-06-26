require_relative '../piece'

class Bishop < Piece
  def intitialize
    super(color, position)
  end
end