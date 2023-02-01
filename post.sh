#!/bin/bash

cd ./Users
sender=$1
receiver=$2
#check that the sender exists

if [ ! -d $sender  ]; then
  cd ..
  echo "nok: user $sender does not exist" > Pipes/$sender
  exit 0
fi
#check that the receiver exists

if [ ! -d $receiver ]; then
  cd ..
  echo "nok: user $receiver does not exist" > Pipes/$sender
  exit 0
fi

#check thats either the sender is a friend of the receiver or is the receiver themselves

if  grep "$sender" "$receiver"/friends.txt > /dev/null || [ $sender = $receiver ];then
  shift 2
  echo "$sender: $*" >> "$receiver"/wall.txt
  cd ..
  echo "ok: message posted!" > Pipes/$sender
else
  cd ..
  echo "nok: $sender is not a friend of $receiver" > Pipes/$sender
fi
