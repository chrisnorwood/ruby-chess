require 'pieces/pawn'

describe Pawn do
  subject(:white_pawn) { Pawn.new(:w, [0,1]) }

  subject(:black_pawn) { Pawn.new(:b, [0,6]) }


  describe "#initialize" do
    it { expect(black_pawn).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    describe "white pawn" do
      context "on home row" do
        let(:moves) { [[0,2], [0,3], [1,2]] }
        
        it "returns attack moves and both upward moves (single and double)" do
          expect(white_pawn.possible_moves).to match_array moves
        end
      end

      context "not on home row" do
        let(:white_pawn_moved) { Pawn.new(:w, [0,2]) }
        let(:moves) { [[0,3], [1,3]] }
        
        it "returns attack moves and one upward move (single)" do
          expect(white_pawn_moved.possible_moves).to match_array moves
        end
      end
    end

    describe "black pawn" do
      context "on home row" do
        let(:moves) { [[0,5], [0,4], [1,5]] }
        
        it "returns attack moves and both downward moves (single and double)" do
          expect(black_pawn.possible_moves).to match_array moves
        end
      end

      context "not on home row" do
        let(:black_pawn_moved) { Pawn.new(:b, [1,4]) }
        let(:moves) { [[1,3], [0,3], [2,3]] }

        it "returns attack moves and one downward move (single)" do
          expect(black_pawn_moved.possible_moves).to match_array moves
        end
      end
    end
  end
end