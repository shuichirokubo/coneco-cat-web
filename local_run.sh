#!/bin/bash

export HUBOT_TWITTER_KEY="9s14KHqUPMIn6E4dsULmCf7Wx"
export HUBOT_TWITTER_SECRET=" lGwtw8nrQTh8HU0sC7xrxJaGDIri7QEMLZyPvvnGWYk7i2uYyS"
export HUBOT_TWITTER_TOKEN="3546734059-ajH8CjAdsTBWdhrTnhdgOGlrfSg01HnQOGk0b2d"
export HUBOT_TWITTER_TOKEN_SECRET=" fuk1fKZiqB8jCkx9IDGOa4XgKFCYJk4nguFLDshn3CX6E"

forever start -c coffee node_modules/.bin/hubot -a twitter-userstream -n coneco_cat
