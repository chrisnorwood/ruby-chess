require 'player'

describe Player do
  before :all do
    @player1 = Player.new(:w)
    @player2 = Player.new(:b)
  end

  context "#initialize" do
    it "has color attribute" do
      expect(@player1).to have_attributes(:color => :w)
      expect(@player2).to have_attributes(:color => :b)
    end
  end
end