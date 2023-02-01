#!/bin/bash
if [ ! $@ == "" ]; then

clear
BLUE_TEXT=`tput setaf 4`
YELLOW_TEXT=`tput setaf 3`
RESET=`tput sgr0`

id=$1

if [ ! -d "Pipes" ]; then
  mkdir "Pipes"
fi

if [ !  -e "Pipes/$id"  ]; then
  cd Pipes
  mkfifo "$id"
  cd ..
fi

trap 'rm Pipes/$id ; exit 0'  INT

echo "${BLUE_TEXT}__________               .__      __________               __
\______   \_____    _____|  |__   \______   \ ____   ____ |  | __
 |    |  _/\__  \  /  ___/  |  \   |    |  _//  _ \ /  _ \|  |/ /
 |    |   \ / __ \_\___ \|   Y  \  |    |   (  <_> |  <_> )    <
 |______  /(____  /____  >___|  /  |______  /\____/ \____/|__|_ \"
 ${RESET}"
echo "Welcome to Bashbook!"
echo "

${BLUE_TEXT}Accepted commands: ${RESET}
${YELLOW_TEXT}create [id]${RESET}: creates a new user .
${YELLOW_TEXT}add [id1] [id2]${RESET}: adds user 2 to user 1's list of friends.
${YELLOW_TEXT}display [id]${RESET}: displays all messages sent to a users wall.
${YELLOW_TEXT}post [id1] [id2] \"[message]\"${RESET}: sends a message from user 1 to user 2's wall. Note: user 1 must be one of user 2's friends, or be user 2 themself.
${YELLOW_TEXT}exit${RESET}: exits BashBook.

"

while [ true ]
do
  read input
  IFS=' ' read -r -a arrayInput <<< "$input"

  for i in {4..1}; do :
       x=$((i + 1))
       arrayInput[x]=${arrayInput[i]}
    done
  arrayInput[1]="$id"
  echo ${arrayInput[@]} > Pipes/server

  read serverOutput < Pipes/$id
  IFS=' ' read -r -a arrayOutput <<< "$serverOutput"
  if [ "${arrayOutput[0]}" = "nok:" ]; then
    arrayOutput[0]="FAILURE:"
  fi

  if [ "${arrayOutput[0]}" = "ok:" ]; then
    arrayOutput[0]="SUCCESS:"
  fi
  echo ${arrayOutput[*]}
done

echo "Goodbye"
sleep 3
clear

fi
