require "rails_helper"

RSpec.describe ChessPiece do
  describe "#horizontal_move?" do
    context "given a piece at [4, 4]" do
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4)}
      it "will return true when trying to move to [5,4]" do
        expect(piece.horizontal_move?(5,4)).to be_truthy
      end
      it "will return false when trying to move to [4,5]" do
        expect(piece.horizontal_move?(4,5)).to be_falsey
      end
    end
  end

  describe "#vertical_move?" do
    context "given a piece at [4, 4]" do
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4)}
      it "will return true when trying to move to [4,6]" do
        expect(piece.vertical_move?(4,6)).to be_truthy
      end
      it "will return false when trying to move to [5,4]" do
        expect(piece.vertical_move?(5,4)).to be_falsey
      end
    end
  end

  describe "#diagonal_move?" do
    context "given a piece at [4, 4]" do
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4)}
      it "will return false when trying to move to [4,6]" do
        expect(piece.diagonal_move?(4,6)).to be_falsey
      end
      it "will return true when trying to move to [5,5]" do
        expect(piece.diagonal_move?(5,5)).to be_truthy
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [4, 4]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 4, position_y: 6, game: game)}
      it "will return true when trying to move to [4,7]" do
        second_piece
        expect(piece.is_obstructed?(4,7)).to be_truthy
      end
      it "will return false when trying to move to [4,5]" do
        second_piece
        expect(piece.is_obstructed?(4,5)).to be_falsey
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [4, 4]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 6, position_y: 4, game: game)}
      it "will return true when trying to move to [7,4]" do
        second_piece
        expect(piece.is_obstructed?(7,4)).to be_truthy
      end
      it "will return false when trying to move to [5,4]" do
        second_piece
        expect(piece.is_obstructed?(5,4)).to be_falsey
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [4, 4] and a piece at [4,3]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 4, position_y: 3, game: game)}
      it "will return true when trying to move to [4,2]" do
        second_piece
        expect(piece.is_obstructed?(4,2)).to be_truthy
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [5,5] and a piece at [4,5]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 5, position_y: 5, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 4, position_y: 5, game: game)}
      it "will return true when trying to move to [2,5]" do
        second_piece
        expect(piece.is_obstructed?(2,5)).to be_truthy
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [0.0] and a piece at [2,2]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 0, position_y: 0, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 2, position_y: 2, game: game)}
      it "will return true when trying to move to [4,4]" do
        second_piece
        expect(piece.is_obstructed?(4,4)).to be_truthy
      end
      it "will return false when trying to move to [1,1]" do
        second_piece
        expect(piece.is_obstructed?(1,1)).to be_falsey
      end
    end
  end

  describe "#is_obstructed?" do
    context "given a piece at [4,4] and a piece at [2,2]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game)}
      let(:second_piece) {ChessPiece.create(position_x: 2, position_y: 2, game: game)}
      it "will return true when trying to move to [0,0]" do
        second_piece
        expect(piece.is_obstructed?(0,0)).to be_truthy
      end
      it "will return false when trying to move to [3,3]" do
        second_piece
        expect(piece.is_obstructed?(3,3)).to be_falsey
      end
    end
  end

  describe "#legal_move?" do
    context "given a piece at [4, 4]" do
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4)}
      it "will return true when trying to move to [6,6]" do
        expect(piece.legal_move?(6,6)).to be_truthy
      end
      it "will return false when trying to move to [-1,-1]" do
        expect(piece.legal_move?(-1,-1)).to be_falsey
      end
      it "will return false when trying to move to [8,8]" do
        expect(piece.legal_move?(8,8)).to be_falsey
      end
    end
  end

  describe "#capture" do
    context "given a black piece at [4,4] and a white piece at [5,5]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game, color: "Black")}
      let(:second_piece) {ChessPiece.create(position_x: 5, position_y: 5, game: game, color: "White")}
      let(:third_piece) {ChessPiece.create(position_x: 3, position_y: 3, game:game, color: "Black")}
      it "will return true if piece.color != second_piece.color" do
        second_piece
        expect(piece.capture(5,5)).to be_truthy
      end
      it "will return false if piece.color == third_piece.color" do
        third_piece
        expect(piece.capture(3,3)).to be_falsey
      end
    end
  end

  describe "#take_piece" do
    context "given a black piece at [4,4] and a white piece at [5,5] and a black piece at [3,3]" do
      let(:game) {Game.create}
      let(:piece) {ChessPiece.create(position_x: 4, position_y: 4, game: game, color: "Black")}
      let(:second_piece) {ChessPiece.create(position_x: 4, position_y: 6, game: game, color: "White")}
      let(:third_piece) {ChessPiece.create(position_x: 4, position_y: 3, game: game, color: "Black")}
      it "will update piece to new coordinates and eat piece" do
        piece.take_piece(second_piece.position_x, second_piece.position_y)

        piece.reload
        expect(piece.position_x).to eq(second_piece.position_x)
        expect(piece.position_y).to eq(second_piece.position_y)
        expect(ChessPiece.find_by(id: second_piece.id)).to be_nil
      end
      it "will not update piece if piece.color == third_piece.color" do
        piece.reload
        piece.take_piece(third_piece.position_x, third_piece.position_y)
        expect(piece.position_x).not_to eql(third_piece.position_x)
        expect(piece.position_y).not_to eql(third_piece.position_y)
        expect(ChessPiece.find_by(id: third_piece.id)).to be_truthy
      end
    end
  end


end
