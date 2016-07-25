require_relative '../piece'

class Pawn < Piece
  def initialize(color, position)
    super(color, position)
    @icon = 'P'
    @jumper = true
    create_vectors
  end

  private

  def create_vectors
    case color
    when :w
      white_vectors
    when :b
      black_vectors
    end
  end

  def white_vectors
    move_vectors << [0,1] << [1,1] << [-1,1]
    if y_position == 1
      move_vectors << [0,2]
    end
    attack_only_vectors << [1,1] << [-1,1]
  end

  def black_vectors
    move_vectors << [0,-1] << [1,-1] << [-1,-1]
    if y_position == 6
      move_vectors << [0,-2]
    end
    attack_only_vectors << [1,-1] << [-1,-1]
  end
end