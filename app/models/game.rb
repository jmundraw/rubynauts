class Game < ActiveRecord::Base
  has_many :matches
  has_many :users, through: :matches
  has_many :chess_pieces

  def populate_board
  	Rook.create(x_position: 0, y_position: 0, color: :black)
  	Knight.create(x_position: 0, y_position: 1, color: :black)
  	Bishop.create(x_position: 0, y_position: 2, color: :black)
  	Queen.create(x_position: 0, y_position: 3, color: :black)
  	King.create(x_position: 0, y_position: 4, color: :black)
  	Bishop.create(x_position: 0, y_position: 5, color: :black)
  	Knight.create(x_position: 0, y_position: 6, color: :black)
  	Rook.create(x_position: 0, y_position: 7, color: :black)
  	Pawn.create(x_position: 1, y_position: 0, color: :black)
  	Pawn.create(x_position: 1, y_position: 1, color: :black)
  	Pawn.create(x_position: 1, y_position: 2, color: :black)
  	Pawn.create(x_position: 1, y_position: 3, color: :black)
  	Pawn.create(x_position: 1, y_position: 4, color: :black)
  	Pawn.create(x_position: 1, y_position: 5, color: :black)
  	Pawn.create(x_position: 1, y_position: 6, color: :black)
  	Pawn.create(x_position: 1, y_position: 7, color: :black)

  	Rook.create(x_position: 0, y_position: 0, color: :white)
  	Knight.create(x_position: 0, y_position: 1, color: :white)
  	Bishop.create(x_position: 0, y_position: 2, color: :white)
  	Queen.create(x_position: 0, y_position: 3, color: :white)
  	King.create(x_position: 0, y_position: 4, color: :white)
  	Bishop.create(x_position: 0, y_position: 5, color: :white)
  	Knight.create(x_position: 0, y_position: 6, color: :white)
  	Rook.create(x_position: 0, y_position: 7, color: :white)
  	Pawn.create(x_position: 1, y_position: 0, color: :white)
  	Pawn.create(x_position: 1, y_position: 1, color: :white)
  	Pawn.create(x_position: 1, y_position: 2, color: :white)
  	Pawn.create(x_position: 1, y_position: 3, color: :white)
  	Pawn.create(x_position: 1, y_position: 4, color: :white)
  	Pawn.create(x_position: 1, y_position: 5, color: :white)
  	Pawn.create(x_position: 1, y_position: 6, color: :white)
  	Pawn.create(x_position: 1, y_position: 7, color: :white)
  end
end
