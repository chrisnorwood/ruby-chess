require_relative '../../lib/pieces/knight.rb'

describe Knight do
  before :all do
    @knight = Knight.new(:w, [4,0])
  end

  context "#initialize" do
    it { expect(@knight).to be_kind_of Piece }
  end
end