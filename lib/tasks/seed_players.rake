ROSTER_URL = 'http://stats.nba.com/stats/commonteamroster?Season=2017-18&TeamID='
PLAYER_DATA_URL = 'http://stats.nba.com/stats/commonplayerinfo?PlayerID='
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
      url = PLAYER_DATA_URL + player.nba_id.to_s
      response = RestClient.get(url, HEADERS)
      data = JSON.parse(response)['resultSets'].first['rowSet'].first

      player.update(
        first_name: data[1],
        last_name: data[2],
        height: data[10],
        weight: data[11]
      )
    end
  end
end
