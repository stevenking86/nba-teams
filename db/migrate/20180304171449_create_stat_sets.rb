class CreateStatSets < ActiveRecord::Migration[5.0]
  def change
    create_table :stat_sets do |t|
      t.references :player
      t.string :group_set
      t.string :group_value
      t.integer :games_played
      t.integer :wins
      t.integer :losses
      t.decimal :w_pct
      t.decimal :min
      t.decimal :fgm
      t.decimal :fga
      t.decimal :fg3m
      t.decimal :fg3a
      t.decimal :fg3_pct
      t.decimal :ftm
      t.decimal :fta
      t.decimal :ft_pct
      t.decimal :oreb
      t.decimal :dreb
      t.decimal :reb
      t.decimal :ast
      t.decimal :tov
      t.decimal :stl
      t.decimal :blk
      t.decimal :blka
      t.decimal :pf
      t.decimal :pfd
      t.decimal :pts
      t.decimal :plus_minus

      t.timestamps
    end
  end
end
