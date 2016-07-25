require_relative '../piece'

class Queen < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'Q'
    @jumper = false
    create_vectors
  end

  public

  def create_vectors
    create_horizontal_vectors
    create_vertical_vectors
    create_diagonal_vectors
  end
end