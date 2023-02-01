#!/bin/bash
clear
BLUE_TEXT=`tput setaf 4`
YELLOW_TEXT=`tput setaf 3`
RESET=`tput sgr0`

if [ ! -d "Pipes" ]; then
  mkdir "Pipes"
fi

if [ !  -e "Pipes/server"  ]; then
  cd Pipes
  mkfifo server
  cd ..
fi

if [ ! -d "Users" ]; then
  mkdir "Users"
fi
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
  read var1 var2 var3 var4 < Pipes/server
  case $var1 in
    create)
      bash create.sh $var2
      ;;
    add)
      bash add_friend.sh $var2 $var3
      ;;
    display)
      bash display.sh $var2
      ;;
    post)
      echo $var1 $var2 $var3 $var4
      sender=$var2
      receiver=$var3
      bash post.sh $sender $receiver $var4
      ;;
    exit)
      break
      ;;
    *)
      echo "${BLUE_TEXT}Accepted commands: ${RESET} create|add|display|post|exit"
      echo "nok: no identifier provided" > Pipes/$var1
      ;;
    esac
done

echo "Goodbye"
sleep 3
clear
