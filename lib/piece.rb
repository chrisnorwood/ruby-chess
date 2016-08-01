class Piece
  attr_accessor :color, :position, :icon
  attr_reader   :move_vectors, :attack_only_vectors, :jumper

  def initialize(color, position)
    @color               = color
    @position            = position
    @move_vectors        = []
    @attack_only_vectors = []
  end

  public

  # this returns the possible moves for any given piece, without knowledge of the board
  # if the piece has attack_only_vectors, it will return ONLY non attack moves, unless :attacks=true is passed
  # if the piece has no "attack_only_vectors", it will return the same array whether options are provided or not
  # if position not 'nil' allows for captured pieces to NOT be considered
  def possible_moves(options = {})
    if (options[:attacks] == true && !attack_only_vectors.empty?)
      vectors = attack_only_vectors
    else
      vectors = move_vectors
    end

    moves = []

    unless position.nil?
      vectors.each do |vector|
        next if attack_only_vectors.include?(vector) && options.empty?
        x_shift, y_shift  = vector[0], vector[1]

        moves << [x_position + x_shift, y_position + y_shift]
      end

      moves.select! { |move| move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8 }
    end
    
    return moves
  end

  def x_position
    position[0]
  end

  def y_position
    position[1]
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