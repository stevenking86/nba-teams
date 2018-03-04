class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :nba_id, null: false
      t.string :name
      t.attachment :image

      t.timestamps
    end
  end
end
