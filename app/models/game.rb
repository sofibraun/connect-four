class Game < ActiveRecord::Base

  class NotYourTurnException < Exception; end
  class FinishedGameException < Exception; end

  validates_presence_of :player_1_id, :player_2_id

  has_one :board
  before_create :set_defaults
  after_create :create_board

  def play!(column, player_id)
    raise(FinishedGameException, "the game already has a winner! The winner is player #{self.winner_id}") if self.winner_id.present?
    raise(NotYourTurnException, 'not your turn') if player_id != current_turn_id 
    
    position = board.play!(column, player_id)
    self.current_turn_id = (player_1_id == player_id ? player_2_id : player_1_id)
    if board.check_for_winner(position, player_id)
      self.winner_id = player_id
    end
    save
    position
  end

  def reset!
    self.current_turn_id = player_1_id
    save!
    board.delete
    Board.create(player_1_id: player_1_id, player_2_id: player_2_id, rows: 7, cols: 7, game_id: self.id)
  end

  private

  def set_defaults
    self.current_turn_id = self.player_1_id
  end

  def create_board
    Board.create(player_1_id: player_1_id, player_2_id: player_2_id, rows: 7, cols: 7, game_id: self.id)
  end

end