Senior-Design-Hydra
===================
Upon first pull run `rails g hydra:jetty`—this will install the Jetty bits necessary for hydra. This isn't included in the repo itself because the jetty files are somewhere close to 200MB and don't need to be shoveled to and from github.

###First Time configuration
- `bundle install`
- `rake db:migrate`

###Running the application
- `rake jetty:start`
- `rails s -d`
