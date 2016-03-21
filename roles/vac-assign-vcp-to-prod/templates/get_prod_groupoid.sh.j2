#!/bin/sh

USER={{ vac_root_user }}
PASSWD={{ vac_root_passwd }}
TIMES=$(expr $(curl -s -u $USER:$PASSWD http://localhost/api/v1/group | jq '.list[].name' | wc -l) - 1)

for i in `seq 0 $TIMES`; do
  if [ "$(curl -s -u $USER:$PASSWD http://localhost/api/v1/group | jq '.list['$i'].name == "Production"')" = "true" ]; then
    curl -s -u $USER:$PASSWD http://localhost/api/v1/group | jq '.list['$i']._id[]' | tr -d '\"'
  fi
done