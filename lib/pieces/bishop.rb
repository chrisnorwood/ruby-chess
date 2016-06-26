require_relative '../piece.rb'

class Bishop < Piece
  def intitialize
    super(color, position)
  end
end