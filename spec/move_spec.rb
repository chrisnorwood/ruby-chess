require 'move'
require 'board'
require 'player'

require 'chess'

describe Move do
  let(:board) { Board.new }
  let(:white_player) { Player.new(:w) }
  let(:black_player) { Player.new(:b) }

  let(:played_board) { Board.new }

  describe "#root_piece" do
    context "there is piece at root" do
      # requesting move on left-most white pawn
      let(:move) { Move.new(board, white_player, [0,1], [0,2]) }

      it "returns a piece object" do
        expect(move.root_piece).to be_kind_of Piece
      end
    end

    context "there is not a piece at root" do
      let(:move) { Move.new(board, white_player, [0,2], [0,3]) }
      
      it "returns returns false" do
        expect(move.root_piece).to eql false
      end
    end
  end

  describe "#root_color" do
    context "when root piece exists" do
      let(:move) { Move.new(board, white_player, [0,1], [0,2]) }

      it "returns color of root piece" do
        expect(move.root_color).to eql :w
      end
    end

    context "when root piece doesn't exist" do
      let(:move) { Move.new(board, white_player, [0,3], [0,2]) }
      
      it "returns falsey value" do
        expect(move.root_color).to be_falsey
      end
    end
  end

  describe "#target_color" do
    context "when target piece exists" do
      let(:move) { Move.new(board, white_player, [0,1], [0,6]) }

      it "returns color of target piece" do
        expect(move.target_color).to eql :b
      end
    end

    context "when target piece doesn't exist" do
      let(:move) { Move.new(board, white_player, [0,3], [0,4]) }
      
      it "returns falsey value" do
        expect(move.target_color).to be_falsey
      end
    end
  end

  describe "#root_is_players?" do
    context "when piece belongs to player" do
      let(:move) { Move.new(board, white_player, [0,0], [0,1]) } 

      it "returns true" do
        expect(move.root_is_players?).to eql true
      end 
    end

    context "when piece does not belong to player" do
      let(:move) { Move.new(board, white_player, [0,7], [0,1]) } 

      it "returns false" do
        expect(move.root_is_players?).to eql false
      end
    end
  end

  describe "#in_possibilities?" do
    context "target within realm of possibility" do
      # this is white Knight on freshly initialized board
      let(:move) { Move.new(board, white_player, [1,0], [2,2]) } 

      it "returns true" do
        expect(move.in_possibilities?).to eql true
      end
    end

    context "target out of realm of possibility" do
      let(:move) { Move.new(board, white_player, [1,0], [3,2]) }

      it "returns false" do
        expect(move.in_possibilities?).to eql false
      end
    end
  end

  describe "#in_possible_attacks?" do
    context "when Pawn requests an attack diagonally" do
      # this is pawn moving diagonally
      let(:move) { Move.new(board, white_player, [0,1], [1,2])}

      it "returns true" do
        expect(move.in_possible_attacks?).to eql true
      end
    end

    context "when Knight requests attack in normal move possiblities" do
      # knight moving normally from home position
      let(:move) { Move.new(board, white_player, [1,0], [2,2]) } 

      it "returns true" do
        expect(move.in_possible_attacks?).to eql true
      end
    end

    context "when Pawn requests an attack forward" do
      # this is pawn moving forward
      let(:move) { Move.new(board, white_player, [0,1], [0,2])}
      
      it "returns false" do
        expect(move.in_possible_attacks?).to eql false
      end
    end
  end

  describe "#target_is_players?" do
    context "target belongs to player" do
      let(:move) { Move.new(board, white_player, [1,0], [3,1]) } 

      it "returns true" do
        expect(move.target_is_players?).to eql true
      end
    end

    context "target does not belong to player" do
      let(:move) { Move.new(board, white_player, [1,0], [2,2]) }

      it "returns false" do
        expect(move.target_is_players?).to eql false
      end 
    end
  end

  describe "#make_valid_moves" do
    context "when Knight considered from home row (with valid target)" do
      let(:move) { Move.new(board, white_player, [1,0], [2,2]) }
      let(:exp_valid_moves) { [[2,2], [0,2]] }

      it "returns two valid moves (from three possible)" do
        expect(move.make_valid_moves).to match_array exp_valid_moves
      end
    end

    context "when Pawn considered from home row (with valid target)" do
      let(:move) { Move.new(board, white_player, [2,1], [2,2]) }
      let(:exp_valid_moves) { [[2,2], [2,3]] }

      it "returns two valid moves" do
        expect(move.make_valid_moves).to match_array exp_valid_moves
      end
    end

    context "when Queen considered from home position" do
      context "with valid target" do
        let(:move) { Move.new(board, white_player, [3,0], [4,1]) }

        it "returns no valid moves" do
          expect(move.make_valid_moves).to match_array []
        end
      end

      context "with invalid target" do
        let(:move) { Move.new(board, white_player, [3,0], [5,5]) }

        it "returns no valid moves" do
          expect(move.make_valid_moves).to match_array []
        end
      end
    end

    context "when black Bishop considered from home position" do
      context "with valid target" do
        let(:move) { Move.new(board, black_player, [2,7], [0,5]) }

        it "returns no valid moves" do
          expect(move.make_valid_moves).to match_array []
        end
      end

      context "with invalid target" do
        let(:move) { Move.new(board, black_player, [2,7], [0,0]) }

        it "returns no valid moves" do
          expect(move.make_valid_moves).to match_array []
        end
      end
    end

    context "Board is NOT in default, init. layout" do
      before do
        played_board.pieces = []
        played_board.pieces << King.new(:w, [2,0]) << Queen.new(:w, [4,2])
        played_board.pieces << Pawn.new(:b, [4,6]) << Pawn.new(:b, [6,6]) << King.new(:b, [6,7]) << Bishop.new(:b, [6,4])
      end

      describe "Black Bishop" do
        context "when target is outside of possibilities" do
          let(:move) { Move.new(played_board, black_player, [6,4], [3,4]) }
          
          it "returns no valid moves" do
            expect(move.make_valid_moves).to match_array []
          end
        end

        context "when invalid target within possibilities" do
          let(:move) { Move.new(played_board, black_player, [6,4], [3,1]) }
          let(:expected_moves) { [[7,5], [5,3], [4,2], [5,5], [7,3]] }
          
          it "returns the piece's, actual valid moves" do
            expect(move.make_valid_moves).to match_array expected_moves
          end
        end
      end
    end
  end

  describe "#valid?" do
    before do
      played_board.pieces = []
      played_board.pieces << King.new(:w, [2,0]) << Queen.new(:w, [4,2]) << Pawn.new(:w, [3,5])
      played_board.pieces << Pawn.new(:b, [4,6]) << Pawn.new(:b, [6,6]) << King.new(:b, [6,7]) << Bishop.new(:b, [6,4])
    end

    context "Player requests to move opponent's piece" do
      let(:move) { Move.new(played_board, white_player, [6,6], [5,3]) }
      
      it "returns false" do
        expect(move.valid?).to eql false
      end
    end

    context "Player requests to attack their own piece" do
      let(:move) { Move.new(played_board, black_player, [6,7], [6,6]) }
      
      it "returns false" do
        expect(move.valid?).to eql false
      end
    end

    context "Player requests move outside of that piece's ability" do
      context "Pawn requests to attack into empty square" do
        let(:move) { Move.new(played_board, black_player, [4,6], [5,5]) }
        
        it "returns false" do
          expect(move.valid?).to eql false
        end
      end

      context "Pawn requests to move two spaces while not on home row" do
        let(:move) { Move.new(played_board, white_player, [3,5], [3,7]) }
        
        it "returns false" do
          expect(move.valid?).to eql false
        end
      end
    end

    context "Queen requests a valid move" do
      context "when attacking" do
        let(:move) { Move.new(played_board, white_player, [4,2], [4,6]) }

        it "returns true" do
          expect(move.valid?).to eql true
        end
      end

      context "when not attacking" do
        let(:move) { Move.new(played_board, white_player, [4,2], [0,6]) }

        it "returns true" do
          expect(move.valid?).to eql true
        end
      end
    end
  end

  describe "#execute" do
    let(:move) { Move.new(board, white_player, [0,1], [0,2] )}
    let(:root_position) { move.root_piece.position }
    it "moves a piece from the root to the target" do
      expect{ move.execute }.to change{ move.root_piece.position }.from([0,1]).to([0,2])
    end

    context "when attacking" do
      before do
        played_board.pieces = []
        played_board.pieces << King.new(:w, [1,0]) << Queen.new(:w, [4,2]) << Pawn.new(:w, [3,5])
        played_board.pieces << Pawn.new(:b, [4,6]) << Pawn.new(:b, [6,6]) << King.new(:b, [6,7]) << Bishop.new(:b, [6,4])
      end

      let(:move) { Move.new(played_board, white_player, [4,2], [6,4]) }

      it "moves the root piece to target" do
        expect{ move.execute }.to change{ move.root_piece.position }.from([4,2]).to([6,4])
      end

      it "updates the target piece position to nil" do
        expect{ move.execute }.to change{ move.target_piece.position }.from([6,4]).to(nil)
      end
    end
  end
end