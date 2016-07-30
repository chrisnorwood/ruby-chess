require_relative 'player'
require_relative 'move'

class CheckHelper
  attr_reader :board, :player, :enemy_player, :player_king, :enemy_king

  def initialize(board, player)
    @board        = board
    @player       = player

    @enemy_player = Player.new(enemy_color)
    @player_king  = find_king(player_color)
    @enemy_king   = find_king(enemy_color)
  end

  public

  def in_check?
    status = false

    enemy_pieces.each do |enemy_piece|
      test_move = Move.new(board, enemy_player, enemy_piece.position, player_king.position)
      status = true if test_move.valid?
    end

    return status
  end

  def in_checkmate?
    if in_check?
      status = true

      player_pieces.each do |player_piece|
        fake_board = board.dup
        root_position = player_piece.position
        possibilities = player_piece.possible_moves
        
        possibilities.each do |possible|
          test_move = Move.new(fake_board, player, root_position, possible)
          test_move.execute
          status = false unless CheckHelper.new(fake_board, player).in_check?
        end
      end

      return status
    else
      return false
    end
  end

  private

  def player_color
    player.color
  end

  def enemy_color
    (player.color == :w) ? :b : :w
  end

  def find_king(color)
    pieces.find { |piece| piece.instance_of?(King) && piece.color == color }
  end

  def pieces
    board.pieces
  end

  def player_pieces
    pieces.select { |piece| piece.color == player_color }
  end

  def enemy_pieces
    pieces.select { |piece| piece.color == enemy_color }
  end
end