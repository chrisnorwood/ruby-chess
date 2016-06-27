require_relative '../piece'

class Knight < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'N'
  end
end