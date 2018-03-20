# Who's Hooping?

See it live: https://whos-hooping.herokuapp.com/

##Goal
Who's Hooping is a way to quickly visualize NBA player datasets.

##Technology
This app is built using Ruby on Rails (backend) + HTML + CSS( w/ Foundation) + Jquery on the front end.

##To run locally
- Ensure you have Rails and Postgres downloaded locally.
- Create a postgres db locally called nba_teams_development
- Run `bundle exec rake seed:teams`
- Run `bundle exec rake seed:players`
- Run `rails s`
- Navigate to localhost:3000 to see the app.


###More on the seed:players task
This task will attempt to update your database by hitting stats.nba.com's API.  This API has been known to change without warning.  The task is not currently able to catch any errors that may result in hitting the API.
