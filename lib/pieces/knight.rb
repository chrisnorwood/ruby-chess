require_relative '../piece.rb'

class Knight < Piece
  def intitialize
    super(color, position)
  end
end