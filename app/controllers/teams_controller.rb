class TeamsController < ApplicationController
  def index
    @teams = Team.all.pluck(:name, :id)
    @team = Team.find_by id: params['team_id']
    if @team.present?
      @team_players = @team.players.map { |p| [p.name, p.id] }
    else
      @team_players = []
    end

    @player = Player.find_by id: params['player_id']
    @stat_set = StatSet.find_by(id: params['stat_set_id'])

    if params['click'] == '1'
      if params['load_team'] == '1'
        (render partial: 'team',
          locals: {
            team: @team,
            player: @player,
            stat_set: @stat_set
          }
        )
      elsif params['load_player'] == '1'
        (render partial: 'player',
          locals: {
            player: @player,
            stat_set: @player.stat_sets.find_by(group_set: 'Overall') || @player.stat_sets.first
          }
        )
      else
        (render partial: 'stat_set',
          locals: {
            player: @player,
            stat_set: @stat_set
          }
        )
      end
    end
  end

  def chart_set
    player = Player.find params[:player_id]
    group_set = StatSet.find(params[:stat_set_id]).group_set
    stat_type = params[:stat_type]

    @chart_set = player.stat_sets.chart_set_for(stat_type, group_set)

    render json:  @chart_set.to_json
  end
end
