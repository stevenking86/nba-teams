ROSTER_URL = "http://stats.nba.com/stats/commonteamroster?Season=2017-18&TeamID="

namespace :seed do
  task :players => :environment do
    #Just want to create players with their IDs first.


    Team.all.each do |team|
      headers = {
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

      url = ROSTER_URL + team.nba_id.to_s
      binding.pry
      response = RestClient.get(url, headers)
      binding.pry
    end
  end
end
