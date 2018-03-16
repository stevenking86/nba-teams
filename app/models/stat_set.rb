class StatSet < ActiveRecord::Base
  belongs_to :player

  def dar
    #Defensive Activity Rating
    d = (stl + blk) / pf
    return ('%.2f' % d)  if d.present?
    0
  end

  def self.chart_set_for(stat_type, group_set)
    #stat_type is going to match w STAT_TYPE_DATA, ie 'games'
    #Group set is statset's group_set, ie: Starting Position
    stat_sets = where(group_set: group_set).order(:id)

    {
      group_set: group_set,
      stat_type: stat_type,
      categories: stat_sets.pluck(:group_value),
      y_axis: stat_type,
      series_data: STAT_TYPE_DATA[stat_type].map do |attr|
        {
          name: attr.to_s.titleize,
          data: stat_sets.map do |s|
            val = s.send(attr)
            val == 'NaN' ? 0 : val.to_f
          end
        }
      end
    }
  end
end
