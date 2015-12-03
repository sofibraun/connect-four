class Cell

  attr_reader :occupying_player, :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def is_free?
    @occupying_player.nil?
  end

  def occupied_by?(player_id)
    @occupying_player == player_id
  end

  def drop_chip(player_id)
    if is_free?
      @occupying_player = player_id    
    else
      false
    end
  end

end