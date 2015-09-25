#!/bin/bash

export HUBOT_TWITTER_KEY="fCdlZrXTaQFuBcx3SAtq3alJk"
export HUBOT_TWITTER_SECRET="k3aBK3DZMeM0pl0tYk5sKnxniu8WfDWxgOUpPg1JwHsoxS0mF6"
export HUBOT_TWITTER_TOKEN="3546734059-qhSWT3CKaeKty6lZJNEYuVCZpUYNw3sS7LvvZxZ"
export HUBOT_TWITTER_TOKEN_SECRET="BZJLW3xx9zzDEvYIgmdfPqNpXnwyLIeZukyKiQ4LZw4GQ"

forever start -c coffee node_modules/.bin/hubot -a twitter-userstream -n coneco_cat
