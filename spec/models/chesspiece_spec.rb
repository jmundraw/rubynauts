require "rails_helper"

RSpec.describe ChessPiece do
  describe "#horizontal_move?" do
     context "given a piece at [4, 4]" do
       let(:piece) {Chess_Piece.create(position_x: 4, position_y: 4)}
       it "will return true when trying to move to [5,4]" do
        expect(piece.horizontal_move?(5,4)).to be_truthy
       end
     end
   end

 describe "#vertical_move?" do
   context "given a piece at [4, 4]" do
     let(:piece) {Chess_Piece.create(position_x: 4, position_y: 4)}
     it "will return true when trying to move to [4,6]" do
      expect(piece.vertical_move?(4,6)).to be_truthy
     end
   end
 end
end