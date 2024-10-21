#!/bin/bash

# Name or ID of the first container
CONTAINER1="LudditeSync"
# Name or ID of the second container
CONTAINER2="LudditeBuild"


# Start the first container
docker start $CONTAINER1

echo "Started $CONTAINER1, waiting for it to finish..."

# Wait for the first container to stop running
while [ $(docker inspect -f '{{.State.Running}}' $CONTAINER1) = "true" ]; do
  sleep 10
done

echo "$CONTAINER1 has finished."

# Start the second container
docker start $CONTAINER2
echo "Started $CONTAINER2."
