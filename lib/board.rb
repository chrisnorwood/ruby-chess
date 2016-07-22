require_relative 'string'

class Board
  attr_reader :pieces
  # 'pieces' is array of all piece objects to be displayed on board (starts with 16 total)
  def initialize
    @pieces = []
    populate_pieces
  end

  def display
    print "\n".ljust(10)
    print "   A      B      C      D      E      F      G      H   "
    # rows
    8.times do |i|
      # column entries
      3.times do |dim|
        # indents board by 10 spaces
        # labeling the rows by number if in middle of 3 squares
        if dim == 1
          print "\n".ljust(10,"       #{(8-i).to_s}")
        else 
          print "\n".ljust(10)
        end

        8.times do |j|
          # printing from 'black' side down to 'white' side, determines correct square color
          square_color = (i+j)%2 == 0 ? :yellow : :red
          
          # reference i & j as standard x & y coordinates from 0,0 to 7,7
          x = j
          y = 7-i
          coordinate = [x, y]

          if dim == 1
            if @pieces.any?{ |piece| piece.position == coordinate }
              selection = @pieces.select { |piece| piece.position == coordinate }
              piece     = selection[0]

              case piece.color
              when :w then piece_color = :white_b
              when :b then piece_color = :black_w
              end

              print "  ".color(square_color)+" #{piece.icon} ".color(piece_color)+"  ".color(square_color)
            else
              print "       ".color(square_color)
            end
          else
            print "       ".color(square_color)
          end
        end
      end
    end
    print "\n\n"
  end

  private

  def populate_pieces
    add_pawns
    add_rooks
    add_bishops
    add_knights
    add_kings
    add_queens
  end

  def add_pawns
    8.times do |x|
      pieces << Pawn.new(:w, [x, 1])
    end

    8.times do |x|
      pieces << Pawn.new(:b, [x, 6])
    end
  end

  def add_rooks
    pieces << Rook.new(:w, [0,0]) << Rook.new(:w, [7,0])
    pieces << Rook.new(:b, [0,7]) << Rook.new(:b, [7,7])
  end

  def add_bishops
    pieces << Bishop.new(:w, [2,0]) << Bishop.new(:w, [5,0])
    pieces << Bishop.new(:b, [2,7]) << Bishop.new(:b, [5,7])
  end

  def add_knights
    pieces << Knight.new(:w, [1,0]) << Knight.new(:w, [6,0])
    pieces << Knight.new(:b, [1,7]) << Knight.new(:b, [6,7])
  end

  def add_kings
    pieces << King.new(:w, [4,0])
    pieces << King.new(:b, [4,7])
  end

  def add_queens
    pieces << Queen.new(:w, [3,0])
    pieces << Queen.new(:b, [3,7])
  end
end