require_relative '../piece'

class Queen < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'Q'
  end
end