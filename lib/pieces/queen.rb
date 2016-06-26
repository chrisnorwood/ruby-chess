require_relative '../piece.rb'

class Queen < Piece
  def intitialize
    super(color, position)
  end
end