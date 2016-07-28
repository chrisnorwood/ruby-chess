class Move
  attr_accessor :status, :failure, :valid_moves, :temp_moves
  attr_reader   :board, :player, :root, :target

  def initialize board, player, root, target
    @board       = board
    @player      = player
    @root        = root
    @target      = target

    @temp_moves  = []
    @valid_moves = make_valid_moves
  end

  public

  def valid?
    valid_moves.include?(target)
  end

  def make_valid_moves
    if root_is_players? && (in_possibilities? || in_possible_attacks?)
      if attack_attempt?
        temp_moves = possible_attack_moves
      else
        temp_moves = possible_moves
      end

      # prunes positions that contain own piece from valid_moves, but doesn't remove blank squares
      temp_moves.reject! do |possible| 
        piece_at_position(possible).color == player_color unless piece_at_position(possible) == false
      end

      # prunes positions that are not on clear linear path for sliding/non-jumper pieces --> CLEAR `IN_BETWEEN`
      unless root_is_jumper?
        temp_moves.reject! { |possible| in_between?(root, possible) }
      end
    end

    temp_moves.nil? ? [] : temp_moves
  end

  def attack_attempt?
    (target_piece && !target_is_players?) ? true : false
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

  def in_possible_attacks?
    possible_attack_moves.find { |move| move == target } ? true : false
  end

  def root_is_jumper?
    root_piece.jumper
  end

  # define important properties of each move:

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

  def possible_attack_moves
    root_piece.possible_moves(attacks: true)
  end

  # helpers for in_between calculations
  def min(a,b)
    a < b ? a : b
  end

  def max(a,b)
    a > b ? a : b
  end
  #######

  def in_between?(from, to)
    from_x, from_y, to_x, to_y = from[0], from[1], to[0], to[1]
    
    rise,    run     = from_y - to_y,     from_x - to_x
    max_x,   min_x   = max(from_x, to_x), min(from_x, to_x)
    max_y,   min_y   = max(from_y, to_y), min(from_y, to_y)
    delta_x, delta_y = max_x - min_x,     max_y - min_y

    if (rise == 0 && run != 0)
      return in_between_horizontally?(from_y, min_x, max_x, delta_x)
    end

    if (run == 0 && rise != 0)
      return in_between_vertically?(from_x, min_y, max_y, delta_y)
    end

    if (run != 0 && (rise/run == 1 || rise/run == -1))
      return in_between_diagonally?(from_x, from_y, to_x, to_y, delta_x, delta_y)
    end
  end

  def in_between_horizontally?(from_y, min_x, max_x, delta_x)
    if delta_x > 1
      status = false
      (min_x+1).upto(max_x-1) do |try_x|
        status = true if piece_at_position([try_x, from_y])
      end
      return status
    else
      false
    end
  end

  def in_between_vertically?(from_x, min_y, max_y, delta_y)
    if delta_y > 1
      status = false
      (min_y+1).upto(max_y-1) do |try_y|
        status = true if piece_at_position([from_x, try_y])
      end
      return status
    else
      false
    end
  end

  def in_between_diagonally?(from_x, from_y, to_x, to_y, delta_x, delta_y)
    # must be further than one square diagonally away
    if delta_x > 1 && delta_y > 1
      status = false
      # 'to' is left
      if to_x < from_x
        (to_x+1).upto(from_x-1) do |try_x|
          shift_y = try_x-to_x
          try_y   = (to_y > from_y) ? to_y-shift_y : to_y+shift_y

          status = true if piece_at_position([try_x, try_y])
        end
      end

      # 'to' is right
      if to_x > from_x
        (from_x+1).upto(to_x-1) do |try_x|
          shift_y = try_x-from_x
          try_y   = (to_y > from_y) ? from_y+shift_y : from_y-shift_y

          status = true if piece_at_position([try_x, try_y])
        end
      end

      return status
    else
      false
    end
  end
end