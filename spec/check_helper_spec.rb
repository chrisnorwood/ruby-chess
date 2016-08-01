require 'check_helper'
require 'board'
require 'player'
require 'game'

describe CheckHelper do
  let(:white_player) { Player.new(:w) }
  let(:black_player) { Player.new(:b) }
  let(:fresh_board)  { Board.new }
  let(:played_board) { Board.new }

  describe "#initialize" do
    let(:check_helper) { CheckHelper.new(fresh_board, white_player) }    

    it do 
      expect(check_helper).to have_attributes(:board => (an_instance_of Board), 
                                              :player => (an_instance_of Player),
                                              :player_king => (an_instance_of King),
                                              :enemy_king => (an_instance_of King)) 
    end
  end

  describe "#in_check?" do
    before do
      played_board.pieces = []
      played_board.pieces << King.new(:w, [4,2]) << Rook.new(:w, [0,0])
      played_board.pieces << King.new(:b, [2,4]) << Queen.new(:b, [6,4])
    end

    context "when requesting player is in check" do
      let(:check_helper) { CheckHelper.new(played_board, white_player) }

      it "returns true" do
        expect(check_helper.in_check?).to eql true
      end
    end

    context "when requesting player is not in check" do
      let(:check_helper) { CheckHelper.new(played_board, black_player) }

      it "returns false" do
        expect(check_helper.in_check?).to eql false
      end
    end
  end

  describe "#in_checkmate?" do
    
    context "board has a checkmate condition for one player" do
      before do
        played_board.pieces = []
        played_board.pieces << King.new(:w, [7,5]) << Rook.new(:w, [4,7])
        played_board.pieces << King.new(:b, [7,7])
      end

      context "when requesting player is in checkmate" do
        let(:check_helper) { CheckHelper.new(played_board, black_player) }

        it "returns true" do
          expect(check_helper.in_checkmate?).to eql true
        end
      end

      context "when requesting player is not in checkmate" do
        let(:check_helper) { CheckHelper.new(played_board, white_player) }

        it "returns false" do
          expect(check_helper.in_checkmate?).to eql false
        end
      end
    end

    context "board is in check for one player, but NOT in checkmate" do
      before do
        played_board.pieces = []
        played_board.pieces << King.new(:w, [4,2]) << Rook.new(:w, [0,0])
        played_board.pieces << King.new(:b, [2,4]) << Queen.new(:b, [6,4])
      end

      context "requesting player in check, but not mate" do
        let(:check_helper) { CheckHelper.new(played_board, white_player) }

        it "returns false" do
          expect(check_helper.in_checkmate?).to eql false
        end
      end

      context "requesting player not in check, and not in mate" do
        let(:check_helper) { CheckHelper.new(played_board, black_player) }

        it "returns false" do
          expect(check_helper.in_checkmate?).to eql false
        end
      end
    end
  end
end