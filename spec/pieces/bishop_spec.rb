require 'pieces/bishop'

describe Bishop do
  subject(:bishop) { Bishop.new(:w, [2,0]) }
  let(:moves) { [[0,2], [1,1], [3,1], [4,2], [5,3], [6,4], [7,5]] }

  describe "#initialize" do
    it { expect(bishop).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    it "returns all possible spaces that might be moved onto" do
      expect(bishop.possible_moves).to match_array moves
    end 
  end
end