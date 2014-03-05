#!/bin/bash

# start the jetty server
bundle exec rake jetty:start

# start the rails server
bundle exec rails s -d
