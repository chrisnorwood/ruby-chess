require_relative '../piece'

class King < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'K'
  end
end