class Player < ActiveRecord::Base
  has_many :stat_sets
  belongs_to :team

  def name
    first_name + ' ' + last_name
  end
end
