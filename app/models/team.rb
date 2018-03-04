class Team < ActiveRecord::Base
  has_many :players
  has_attached_file :image
end
