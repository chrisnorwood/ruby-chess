require 'pieces/rook'

describe Rook do
  before :all do
    @rook = Rook.new(:w, [0,0])
  end

  context "#initialize" do
    it { expect(@rook).to be_kind_of Piece }
  end
end