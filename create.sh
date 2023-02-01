#!/bin/bash

name=$1

#check that the user actually entered a name
if [[ $@ == "" ]];
then
    echo "nok: no identifier provided" > Pipes/$name
    exit 1
fi

#check that the user does not already exist
if [ -d Users/$name ];
then
    echo "nok: user already exists" > Pipes/$name
    exit 1
fi

#creates new file and adds txt files to it
mkdir Users/$name
touch Users/$name/friends.txt
touch Users/$name/wall.txt

echo "ok: user created!" > Pipes/$name

exit 0
