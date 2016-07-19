require 'pieces/queen'

describe Queen do
  subject(:queen) { Queen.new(:w, [3,0]) }
  let(:moves) { [[0,0], [1,0], [2,0], [4,0], [5,0], [6,0], [7,0],
                 [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7],
                 [0,3], [1,2], [2,1], [4,1], [5,2], [6,3], [7,4]] }

  describe "#initialize" do
    it { expect(queen).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    it "returns all possible spaces that might be moved onto" do
      expect(queen.possible_moves).to match_array moves
    end
  end
end