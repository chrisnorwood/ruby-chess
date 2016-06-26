require 'pieces/knight'

describe Knight do
  before :all do
    @knight = Knight.new(:w, [1,0])
  end

  context "#initialize" do
    it { expect(@knight).to be_kind_of Piece }
  end
end