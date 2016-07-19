class Piece
  attr_accessor :color, :position, :icon
  attr_reader   :move_vectors

  def initialize(color, position)
    @color    = color
    @position = position
  end

  public

  def possible_moves
    moves = []

    move_vectors.each do |vector|
      shift_x, shift_y  = vector[0], vector[1]
      start_x, start_y  = position[0], position[1]

      moves << [start_x+shift_x, start_y+shift_y]
    end

    moves.select! { |move| move[0] >= 0 && move[0] <= 8 && move[1] >= 0 && move[1] <= 8 }
    
    return moves
  end
end