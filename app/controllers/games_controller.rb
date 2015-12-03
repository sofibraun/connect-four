class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.last || Game.create(player_1_id: 1, player_2_id: 2)
    @player = params[:id]
    @board = @game.board
  end

  def play
    player = params[:id].to_i
    column = params[:column].to_i    
    @game = Game.last
    position = @game.play!(column, player)
    render json: { status: 'ok', game: @game,
                   last_move: position,
                   player: (player == @game.player_1_id ? 'player_1' : 'player_2') }    
  rescue Exception => e
    render json: { status: :error, message: e.message }
  end

  def refresh

  end

  def reset
    
  end
end
