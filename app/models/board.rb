class Board

  attr_reader :player_1, :player_2, :rows, :cols, :current_player

  def initialize(player_1, player_2, rows=7, cols=7)
    @player_1 = player_1
    @player_2 = player_2
    @rows = rows
    @cols = cols
    @current_player = @player_1
    initialize_board
  end

  def reset
    @current_player = player_1
    initialize_board
  end

  def play(column, player_id)
    row = find_free_row(column)
    if !row.nil?
      drop_chip(row, column, player_id)
      check_for_winner([row, column], player_id)
    end
  end

  def drop_chip(row, column, player_id)
    if @current_player == player_id && @cells[row][column].drop_chip(player_id)
      @current_player = (@player_1 == player_id ? @player_2 : @player_1)
    else
      false
    end
  end

  def find_free_row(column) 
    for row in (@rows-1).downto(0) do
      return row if @cells[row][column].is_free?
    end
    return nil
  end

  def check_for_winner(last_move, player_id)
    won_horizontally?(player_id, last_move) ||
    won_vertically?(player_id, last_move) ||
    won_diagonal_left?(player_id, last_move) ||
    won_diagonal_right?(player_id, last_move)
  end

  private

  def initialize_board 
    @cells = []
    for x in 0...rows do
      row = []
      for y in 0...cols do
        row << Cell.new(x, y)
      end 
      @cells << row
    end
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
      if col < 0 || row < 0 || col > (@cols - 1) || row > (@rows - 1) || !@cells[row][col].occupied_by?(player_id)
        return count
      else
        count += 1
      end
    end
    return count
  end

end
