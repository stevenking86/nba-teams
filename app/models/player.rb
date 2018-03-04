class Player < ActiveRecord::Base
  has_many :stat_sets
  belongs_to :team
end
