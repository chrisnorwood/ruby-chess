require_relative '../../lib/pieces/pawn.rb'

describe Pawn do
  before :all do
    @pawn = Pawn.new(:w, [0,1])
  end

  context "#initialize" do
    it { expect(@pawn).to be_kind_of Piece }
  end
end