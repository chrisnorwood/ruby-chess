class Move
  attr_accessor :status
  attr_reader   :board, :player, :root, :target

  def initialize board, player, root, target
    @board  = board
    @player = player
    @root   = root
    @target = target
  end

  def root_piece
    piece_at_position(root)
  end

  def target_piece
    piece_at_position(target)
  end

  def root_color
    root_piece.color if root_piece
  end

  def target_color
    target_piece.color if target_piece
  end

  def root_is_players?
    root_color == player_color
  end

  def target_is_players?
    target_color == player_color
  end

  def in_possibilities?
    possible_moves.find { |move| move == target } ? true : false
  end

  private

  def pieces
    board.pieces
  end

  def piece_at_position(coordinate)
    pieces.find { |piece| piece.position == coordinate } || false
  end

  def player_color
    player.color
  end

  def possible_moves
    root_piece.possible_moves
  end
end