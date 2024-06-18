#!/bin/bash
#good test
curl -sX PUT \
     -H "ContentType: application/json" \
     -H "Accept: application/json" \
      http://0.0.0.0:4567/setLogFileTo/ufw.log-gnomecraft.gz

#hacker test

#curl -sX PUT \
#     -H "ContentType: application/json" \
#     -H "Accept: application/json" \
#      http://0.0.0.0:4567/setLogFileTo/auth.log.X.gz
