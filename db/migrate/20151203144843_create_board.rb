class CreateBoard < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :game_id, null: :false
      t.integer :player_1_id, null: :false
      t.integer :player_2_id, null: :false
      t.integer :rows, null: :false
      t.integer :cols, null: :false
      t.text :cells, array: true
    end
  end
end
