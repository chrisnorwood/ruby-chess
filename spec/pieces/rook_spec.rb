require 'pieces/rook'

describe Rook do
  subject(:rook) { Rook.new(:w, [0,0]) }
  let(:moves) { [[0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], 
                 [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0]] }

  describe "#initialize" do
    it { expect(rook).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    it "returns all possible spaces that might be moved onto" do
      expect(rook.possible_moves).to match_array moves
    end
  end
end