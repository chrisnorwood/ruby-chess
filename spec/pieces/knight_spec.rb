require 'pieces/knight'

describe Knight do
  subject(:knight) { Knight.new(:w, [1,0]) }

  describe "#initialize" do
    it { expect(knight).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    it "returns all possible spaces that might be moved onto" do
      expect(knight.possible_moves).to match_array [[0,2], [2,2], [3,1]]
    end 
  end
end