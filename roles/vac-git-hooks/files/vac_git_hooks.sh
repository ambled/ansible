#!/bin/bash

# git hook file
newrev="$3"
tree_sha1=$(git cat-file -p "$newrev" | awk '$1 == "tree" { print $2 }')
settings_sha1=$(git cat-file -p "$tree_sha1" | awk '$4 == ".vacrc" { print $3 }')
GROUP_ID="$(git cat-file -p "$settings_sha1" | awk '$1 == "GROUP_ID" { print $2}')"
VCL_ID="$(git cat-file -p "$settings_sha1" | awk '$1 == "VCL_ID" { print $2}')"
USER_PASSWD="$(git cat-file -p "$settings_sha1" | awk '$1 == "USER_PASSWD" { print $2}')"
VAC_LOCATION="$(git cat-file -p "$settings_sha1" | awk '$1 == "VAC_LOCATION" { print $2}')"
FILE_NAME="$(git cat-file -p "$settings_sha1" | awk '$1 == "FILE_NAME" { print $2}')"

PREVIOUS_HEAD=$(curl -u $USER_PASSWD $VAC_LOCATION/api/v1/vcl/$VCL_ID/head | python -mjson.tool  | grep \$oid | awk -F \" '{ print $4 }' )

echo VCL branch id is: $VCL_ID
echo Group id is:      $GROUP_ID
echo Previous head is: $PREVIOUS_HEAD

echo Save and verify VCL for compile or syntax error against the group
SAVE_STATUS=$(curl -u $USER_PASSWD -H "Content-Type: text/plain" -X POST —data-binary "@$FILE_NAME" $VAC_LOCATION/api/v1/vcl/$VCL_ID/push -s -w "%{http_code}" -o /dev/null )

# if the save status is 200, then the VCL is uploaded ok and saved on all varnish cache, ready for deployment
# 400 status code means there are syntax error (see the payload for more details)

rollback() {
    echo "Rolling back to last known state"
    ROLLBACK_STATUS=$(curl -u $USER_PASSWD -H "Content-Type: text/plain" -X POST $VAC_LOCATION/api/v1/vcl/$VCL_ID/push/$PREVIOUS_HEAD -s -w "%{http_code}" -o /dev/null )
    echo $ROLLBACK_STATUS 
    echo Rollback complete
    exit 1
}

if [ $SAVE_STATUS -eq 200 ]
    then 
        echo Verified. Now deploying VCL...
        DEPLOY_STATUS=$(curl -u $USER_PASSWD -X PUT $VAC_LOCATION/api/v1/group/$GROUP_ID/vcl/$VCL_ID/deploy -s -w "%{http_code}" -o /dev/null )
        if [ $DEPLOY_STATUS -eq 200 ]
            then
                echo Deployed.
                exit 0 
            else
                echo Deployment unsuccessful. Rolling back...
                rollback
        fi
    else
        echo Roll back to last known state
        rollback
fi