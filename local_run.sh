#!/bin/bash

export HUBOT_TWITTER_KEY="3gGBv8Aqtzn9VlkdFlp0ldrtW"
export HUBOT_TWITTER_SECRET="zcRFVsAu4D1P1DrHZgVN9SFx7XqbbGAI06nR5IlDyUnCw4fZx2"
export HUBOT_TWITTER_TOKEN="3546734059-GwCE8snuei0FSd0MpOFeWei32mt0MD9GNiMWhdN"
export HUBOT_TWITTER_TOKEN_SECRET="nYfwEizZ8ZsCyScF5rzOPPKtdQN88OvetidsoRY5UOD0t"

forever start -c coffee node_modules/.bin/hubot -a twitter-userstream -n coneco_cat
