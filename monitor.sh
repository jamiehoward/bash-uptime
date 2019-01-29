#!/bin/bash

###########################################################
#
# Simple up-time monitor
#
# Tags: network, server, monitor, uptime
#
# Use curl to loop through list of sites and check whether
# they are responsive and returning 200 status code
#
###########################################################

# Get the list of sites to hit

SITE_FILE="$(dirname ${BASH_SOURCE[0]})/sites.list"
SITES=`cat $SITE_FILE`

generateSlackCall()
{
    cat <<EOF
{
    "text" : "${MESSAGE}"
}
EOF
}

# Loop through and check each site
echo "Checking sites..."

FAILURES=0
for SITE in $SITES;
do
    RESPONSE=`curl -Is $SITE 2>&1 | head -n 1`

    # If there's a failure, let's notify everything
    if [[ $RESPONSE != *"200"* ]]; then
        ((FAILURES++))
        MESSAGE="The server or application at $SITE is down."
        echo $MESSAGE
        say "A server or application is down!"
        curl -X POST -H 'Content-type: application/json' --data "$(generateSlackCall)" https://hooks.slack.com/services/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 > /dev/null 2>&1
    fi
done

# If everything's good, let's say as much
if [ $FAILURES = 0 ]; then
    echo "All servers are up and returning [200] status code."
fi
