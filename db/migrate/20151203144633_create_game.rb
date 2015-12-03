class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_1_id
      t.integer :player_2_id
      t.integer :board_id
      t.integer :winner_id
      t.integer :current_turn_id
    end
  end
end
