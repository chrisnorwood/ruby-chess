require 'move'
require 'board'
require 'player'

require 'chess'

describe Move do
  let(:board) { Board.new }
  let(:white_player) { Player.new(:w) }

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
end