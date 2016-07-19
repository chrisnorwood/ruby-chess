require 'pieces/king'

describe King do
  subject(:king) { King.new(:w, [4,0]) }

  describe "#initialize" do
    it { expect(king).to be_kind_of Piece }
  end

  describe "#possible_moves" do
    it "returns all possible spaces that might be moved onto" do
      expect(king.possible_moves).to match_array [[3,0], [3,1], [4,1], [5,0], [5,1]]
    end 
  end
end