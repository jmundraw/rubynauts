require 'pry'

class ChessPiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def legal_move?(endpoint_x, endpoint_y)
    (endpoint_x >= 0) && (endpoint_x <= 7) && (endpoint_y >= 0) && (endpoint_y <= 7)
  end

  def horizontal_move?(endpoint_x, endpoint_y)
    (position_x != endpoint_x) && (position_y === endpoint_y)
  end

  def vertical_move?(endpoint_x, endpoint_y)
    (position_y != endpoint_y) && (position_x === endpoint_x)
  end

  def horizontally_obstructed?(endpoint_x, endpoint_y)
    if endpoint_x > position_x
      ((position_x + 1)..(endpoint_x - 1)).find do |x|
        game.piece_in_square?(x, endpoint_y)
      end
    else
      ((position_x - 1).downto(endpoint_x + 1)).find do |x|
        game.piece_in_square?(x, endpoint_y)
      end
    end
  end

  def diagonally_obstructed?(endpoint_x, endpoint_y)
    if (endpoint_x > position_x) && (endpoint_y > position_y)
      y_position = position_y
      ((position_x + 1)..endpoint_x).find do |x|
        y_position = (y_position + 1)
        game.piece_in_square?(x,y_position)
      end
    elsif (endpoint_x < position_x) && (endpoint_y < position_y)
      y_position = position_y
      ((position_x - 1).downto(endpoint_x)).find do |x|
        y_position = (y_position - 1)
        game.piece_in_square?(x,y_position)
      end
    elsif (endpoint_x > position_x) && (endpoint_y < position_y)
      y_position = position_y
      ((position_x + 1)..endpoint_x).find do |x|
        y_position = (y_position - 1)
        game.piece_in_square?(x,y_position)
      end
    elsif (endpoint_x < position_x) && (endpoint_y > position_y)
      y_position = (position_y)
      ((position_x - 1).downto(endpoint_x)).find do |x|
        y_position = (y_position + 1)
        game.piece_in_square?(x,y_position)
      end
    end
  end

  def vertically_obstructed?(endpoint_x, endpoint_y)
    if endpoint_y > position_y
      ((position_y + 1)..(endpoint_y - 1)).find do |y|
        game.piece_in_square?(endpoint_x, y)
      end
    else
      ((position_y - 1).downto(endpoint_y + 1)).find do |y|
        game.piece_in_square?(endpoint_x, y)
      end
    end
  end

  def diagonal_move?(endpoint_x, endpoint_y)
    (endpoint_x - position_x) == (endpoint_y - position_y)
  end

  def is_obstructed?(endpoint_x, endpoint_y)
    if horizontal_move?(endpoint_x, endpoint_y)
      return horizontally_obstructed?(endpoint_x, endpoint_y)
    elsif vertical_move?(endpoint_x, endpoint_y)
      return vertically_obstructed?(endpoint_x, endpoint_y)
    elsif diagonal_move?(endpoint_x, endpoint_y)
      return diagonally_obstructed?(endpoint_x, endpoint_y)
    else
      return false
    end
  end

  def capture(endpoint_x, endpoint_y)
    opponent_piece = game.piece_in_square?(endpoint_x, endpoint_y)

    if self.color != opponent_piece.color
      opponent_piece.destroy
    else 
      return false
    end
  end

  ##for testing purposes
  def valid_move?(*_args)
    true
  end

  def take_piece(endpoint_x, endpoint_y)
    if (self.legal_move?(endpoint_x,endpoint_y) && 
        !self.is_obstructed?(endpoint_x, endpoint_y) && 
        self.valid_move?(endpoint_x,endpoint_y) && 
        self.capture(endpoint_x, endpoint_y))
      self.update_attributes(:position_x => endpoint_x, :position_y => endpoint_y)
    else
      return false
    end
  end

end
