class Piece
  attr_accessor :color, :position, :icon
  attr_reader   :move_vectors

  def initialize(color, position)
    @color        = color
    @position     = position
    @move_vectors = []
  end

  public

  def possible_moves
    moves = []

    move_vectors.each do |vector|
      shift_x, shift_y  = vector[0], vector[1]
      start_x, start_y  = position[0], position[1]

      moves << [start_x+shift_x, start_y+shift_y]
    end

    moves.select! { |move| move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8 }
    
    return moves
  end

  private

  def create_horizontal_vectors
    1.upto(7) do |i|
      # left
      move_vectors << [-i,0]
      # right
      move_vectors << [i,0]
    end
  end

  def create_vertical_vectors
    1.upto(7) do |i|
      # up
      move_vectors << [0,i]
      # down
      move_vectors << [0,-i]
    end
  end

  def create_diagonal_vectors
    1.upto(7) do |i|
      # diagonal line, slope +1
      move_vectors << [i,i]
      move_vectors << [-i,-i]
      # diagonal line, slope -1
      move_vectors << [-i,i]
      move_vectors << [i,-i]
    end
  end
end