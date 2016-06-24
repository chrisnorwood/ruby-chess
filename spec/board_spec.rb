require 'spec_helper'

describe Board do
  before :all do
    @board = Board.new
  end

  context "#initialize" do
    it "initializes @data as array of 8 arrays (rows)" do
      expect(@board.data.size).to eql 8
    end

    it "initializes @data submembers to have 8 column values" do
      expect(@board.data.all? {|i| i.size == 8} ).to eql true
    end
  end

end