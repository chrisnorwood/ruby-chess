require_relative 'player'
require_relative 'board'
require_relative 'move'
require_relative 'check_helper'


class Game
  attr_accessor :players
  attr_reader   :board

  def initialize
    @board         = Board.new
    @players       = [Player.new(:w), Player.new(:b)]
  end

  def play
    until game_over?
      print_game_screen
      
      print "          #{active_player_title} in check!\n" if in_check?(active_player)

      loop do
        print "\n          #{active_player_title}, enter your move: "
        input = gets.chomp
        if input_valid?(input)
          from, to = input.split
          from, to = input_to_coordinate(from), input_to_coordinate(to)

          move = Move.new(board, active_player, from, to)
         
          if move.valid?
            move.execute

            if in_check?(active_player)
              move.reset
              print "\n          You cannot move into check.  Try again."
            else
              switch_players
              break
            end
          else
            print "\n          Invalid move.  Try again."
          end

        elsif input == 'quit'
          exit
        else
          print "         Invalid input. Try again.\n"
        end
      end
    end

    print_game_screen

    print "          #{active_player_title} in checkmate!\n" if in_checkmate?(active_player)
    print "          #{enemy_player_title} in checkmate!\n" if in_checkmate?(enemy_player)
    print "          GAME OVER!!! Thanks for playing. Press enter to quit."
    gets
    exit
  end

  def print_game_screen
    system('clear')
    ascii_title
    print_board
    instructions
  end

  def input_valid?(input)
    (input =~ /^[a-h][1-8]\s[a-h][1-8]$/) ? true : false
  end

  def input_to_coordinate(input)
    column, row = input[0],      input[1]
    x, y        = column.ord-97, row.to_i-1
    return [x, y]
  end

  def switch_players
    players[0], players[1] = players[1], players[0]
  end

  private

  def in_check?(player)
    CheckHelper.new(board, player).in_check?
  end

  def in_checkmate?(player)
    CheckHelper.new(board, player).in_checkmate?
  end

  def game_over?
    (in_checkmate?(active_player) || in_checkmate?(enemy_player)) ? true : false
  end

  def active_player
    players[0]
  end

  def enemy_player
    players[1]
  end

  def active_player_title
    case active_player.color
    when :w then "White"
    when :b then "Black"
    end
  end

  def ascii_title
    title = <<-TITLE
            _____       _              _____ _                   
           |  __ \\     | |            / ____| |                  
           | |__) |   _| |__  _   _  | |    | |__   ___  ___ ___ 
           |  _  / | | | '_ \\| | | | | |    | '_ \\ / _ \\/ __/ __|
           | | \\ \\ |_| | |_) | |_| | | |____| | | |  __/\\__ \\__ \\
           |_|  \\_\\__,_|_.__/ \\__, |  \\_____|_| |_|\\___||___/___/
                               __/ |                             
                              |___/                              
          TITLE
    print title.color(:red_text)
  end

  def instructions
    print <<-INST
        Move format: f3 e5
        (i.e. Move piece at f3 to e5 , if move is valid.)
        You may enter 'quit' at any time to quit.
        INST
  end

  def print_board
    board.display
  end
end