require_relative '../piece'

class Queen < Piece
  def intitialize
    super(color, position)
  end
end