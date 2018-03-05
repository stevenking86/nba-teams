ROSTER_URL = 'http://stats.nba.com/stats/commonteamroster?Season=2017-18&TeamID='
PLAYER_DATA_URL = 'http://stats.nba.com/stats/commonplayerinfo?PlayerID='
PLAYER_SPLITS_URL = 'http://stats.nba.com/stats/playerdashboardbygeneralsplits?LeagueID=00&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlusMinus=N&Position=&Rank=N&RookieYear=&Season=2017-18&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&TeamID=0&VsConference=&VsDivision=&Location=&DateFrom=&DateTo=&GameSegment=&LastNGames=82&PlayerID='

HEADERS = {
        user_agent: ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) '
                          'AppleWebKit/537.36 (KHTML, like Gecko) '
                          'Chrome/45.0.2454.101 Safari/537.36'),
        'referer' => 'http://stats.nba.com/scores/',
        'Accept-Encoding' => 'gzip, deflate',
        'Accept-Language' => 'en-US',
        'Accept' => '*/*',
        'Connection' => 'keep-alive',
        'Cache-Control' => 'no-cache',
        'Origin' => 'http://stats.nba.com',
      }

namespace :seed do
  task :players => :environment do
    puts "Finding or Creating Players for Each Team..."
    Team.all.each do |team|
      url = ROSTER_URL + team.nba_id.to_s
      response = RestClient.get(url, HEADERS)
      all_players = JSON.parse(response)['resultSets'].first['rowSet']

      all_players.each do |player_set|
        team.players.find_or_create_by(nba_id: player_set.last)
      end
    end

    puts "Setting Player Attributes..."

    Player.all.each do |player|
      common_url = PLAYER_DATA_URL + player.nba_id.to_s
      common_response = RestClient.get(common_url, HEADERS)
      common_data = JSON.parse(common_response)['resultSets'].first['rowSet'].first

      player.update(
        first_name: common_data[1],
        last_name: common_data[2],
        height: common_data[10],
        weight: common_data[11]
      )

      player_splits_url = PLAYER_SPLITS_URL + player.nba_id.to_s
      player_splits_response = RestClient.get(player_splits_url, HEADERS)
      stat_sets = JSON.parse(player_splits_response)['resultSets']

      stat_sets.each do |set|
        if set['rowSet'].present? # Players without stats will have an empty rowSet here.
          set['rowSet'].each do |row|
            player.stat_sets.find_by(group_value: row[1]).try(:destroy)

            player.stat_sets.create(
              group_set: row[0],
              group_value: row[1],
              games_played: row[2],
              wins: row[3],
              losses: row[4],
              w_pct: row[5],
              min: row[6],
              fgm: row[7],
              fga: row[8],
              fg_pct: row[9],
              fg3m: row[10],
              fg3a: row[11],
              fg3_pct: row[12],
              ftm:  row[13],
              fta: row[14],
              ft_pct: row[15],
              oreb: row[16],
              dreb: row[17],
              reb: row[18],
              ast: row[19],
              tov: row[20],
              stl: row[21],
              blk: row[22],
              blka: row[23],
              pf: row[24],
              pfd: row[25],
              pts: row[26],
              plus_minus: row[27]
            )
          end
        end
      end
    end
  end
end
