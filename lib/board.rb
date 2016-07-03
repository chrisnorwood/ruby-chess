require_relative 'string'

class Board

  # 'pieces' is array of all piece objects to be displayed on board (starts with 16 total)
  def initialize
    @pieces = [Pawn.new(:w, [0,1]),   Pawn.new(:w, [1,1]),   Pawn.new(:w, [2,1]),   Pawn.new(:w, [3,1]),
               Pawn.new(:w, [4,1]),   Pawn.new(:w, [5,1]),   Pawn.new(:w, [6,1]),   Pawn.new(:w, [7,1]),
               Pawn.new(:b, [0,6]),   Pawn.new(:b, [1,6]),   Pawn.new(:b, [2,6]),   Pawn.new(:b, [3,6]),
               Pawn.new(:b, [4,6]),   Pawn.new(:b, [5,6]),   Pawn.new(:b, [6,6]),   Pawn.new(:b, [7,6]),
               Rook.new(:w, [0,0]),   Rook.new(:w, [7,0]),   Rook.new(:b, [0,7]),   Rook.new(:b, [7,7]),
               Bishop.new(:w, [2,0]), Bishop.new(:w, [5,0]), Bishop.new(:b, [2,7]), Bishop.new(:b, [5,7]),
               Knight.new(:w, [1,0]), Knight.new(:w, [6,0]), Knight.new(:b, [1,7]), Knight.new(:b, [6,7]),
               King.new(:w, [4,0]),   King.new(:b, [4,7]),   Queen.new(:w, [3,0]),  Queen.new(:b, [3,7])]
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
end