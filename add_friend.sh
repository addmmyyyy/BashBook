#!/bin/bash

id=$1
friend=$2

#if statements to check if either user does not exist
if [ ! -d Users/$id ];
then
    echo "nok: user $id does not exist" > Pipes/$id
    exit 1
fi
if [ ! -d Users/$friend ];
then
    echo "nok: user $friend does not exist" > Pipes/$id
    exit 1
fi

# if they haven't already been added as a friend
if  grep -s $friend Users/$id/friends.txt > /dev/null || [ $id = $friend ] ;
then
    echo "Friend already exists" > Pipes/$id
    exit 1
fi

echo $friend >>  Users/$id/friends.txt
echo "ok: friend added!" > Pipes/$id

exit 0
