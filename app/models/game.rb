class Game < ActiveRecord::Base
  has_many :matches
  has_many :users, through: :matches
  has_many :chess_pieces

end
