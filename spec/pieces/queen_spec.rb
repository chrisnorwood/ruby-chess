require_relative '../../lib/pieces/queen.rb'

describe Queen do
  before :all do
    @queen = Queen.new(:w, [3,0])
  end

  context "#initialize" do
    it { expect(@queen).to be_kind_of Piece }
  end
end