class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :height
      t.string :weight
      t.attachment :image
      t.integer :nba_id, null: false

      t.references :team
      t.timestamps
    end
  end
end
