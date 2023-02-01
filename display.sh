#/bin/bash
id=$@
YELLOW_TEXT=`tput setaf 3`
RESET=`tput sgr0`

#check that the user exists
if [ ! -d Users/$id ];
then
    echo "nok: user $id does not exist" > Pipes/$id
    exit 1
fi

echo "${YELLOW_TEXT}Start_of_file${RESET}" > Pipes/$id
#print file to screen
cat Users/$id/wall.txt > Pipes/$id

echo "${YELLOW_TEXT}End_of_file${RESET}" > Pipes/$id

exit 0
