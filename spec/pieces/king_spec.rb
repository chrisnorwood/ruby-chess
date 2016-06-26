require 'pieces/king'

describe King do
  before :all do
    @king = King.new(:w, [4,0])
  end

  context "#initialize" do
    it { expect(@king).to be_kind_of Piece }
  end
end