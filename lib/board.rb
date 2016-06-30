require_relative 'string'

class Board

  # 'pieces' is array of all piece objects to be displayed on board (starts with 16 total)
  def initialize(pieces)
    @pieces = pieces
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