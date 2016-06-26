require_relative '../../lib/pieces/bishop.rb'

describe Bishop do
  before :all do
    @bishop = Bishop.new(:w, [2,0])
  end

  context "#initialize" do
    it { expect(@bishop).to be_kind_of Piece }
  end
end