class Board < ActiveRecord::Base

  class ColumnIsFullException < Exception; end

  belongs_to :game
  validates_presence_of :player_1_id, :player_2_id, :rows, :cols

  before_create :initialize_board

  def play!(column, player_id)
    row = find_free_row(column)    
    self.cells[row][column] = player_id      
    save
    [row, column]
  end

  def find_free_row(column) 
    for row in (rows-1).downto(0) do
      return row if cells[row][column].nil?
    end
    raise ColumnIsFullException, 'column is full'
  end

  def check_for_winner(last_move, player_id)
    won_horizontally?(player_id, last_move) ||
    won_vertically?(player_id, last_move) ||
    won_diagonal_left?(player_id, last_move) ||
    won_diagonal_right?(player_id, last_move)
  end

  private

  def initialize_board 
    self.cells = Array.new(rows) { Array.new(cols) }     
  end

  def won_horizontally?(player_1, position)
    count_left = count_in_line(player_1, position, 0, -1)
    count_right = count_in_line(player_1, position, 0, 1)
    (count_left + count_right + 1) >= 4
  end

  def won_vertically?(player_1, position)    
    count_down = count_in_line(player_1, position, 1, 0)
    (count_down + 1) >= 4
  end

  def won_diagonal_left?(player_1, position)
    count_diagonal_up = count_in_line(player_1, position, -1, -1)
    count_diagonal_down = count_in_line(player_1, position, 1, 1)
    (count_diagonal_up + count_diagonal_down + 1) >= 4
  end

  def won_diagonal_right?(player_1, position)
    count_diagonal_up = count_in_line(player_1, position, -1, 1)
    count_diagonal_down = count_in_line(player_1, position, 1, -1)
    (count_diagonal_up + count_diagonal_down + 1) >= 4
  end

  def count_in_line(player_id, position, row_incrementor, col_incrementor)
    count = 0
    row = position[0]
    col = position[1]
    while(count < 4) do
      row += row_incrementor
      col += col_incrementor
      if col < 0 || row < 0 || col > (cols - 1) || row > (rows - 1) || cells[row][col] != player_id
        return count
      else
        count += 1
      end
    end
    return count
  end
end
