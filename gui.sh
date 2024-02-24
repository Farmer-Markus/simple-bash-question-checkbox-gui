#!/bin/bash

title="Would you like to update?"
button1="Yes"
button2="No"
button3="Cancel"

default="\033[;40m"
green="\033[1;42m"
red="\033[1;41m"

button1color="$green"
button2color="$default"
button3color="$default"



gui () {							#GUI START
widht=$(tput cols)


background=""
i=""
while (( i < $widht )); do
i=$[i+1]
background=""$background"#"
done

titleground=""
i=""
while (( i < $[ $[ widht-$( echo $title | wc -m) ]/2 ] )); do
i=$[i+1]
titleground="$titleground"#
done

button12ground=""
i=""
while (( i < $[ $[ widht-$[ $( echo $button1 | wc -m)+$( echo $button2 | wc -m ) ] ]/3 ] )); do
i=$[i+1]
button12ground="$button12ground"#
done

button3ground=""
i=""
while (( i < $[ $[widht-6]/2 ] )); do
i=$[i+1]
button3ground="$button3ground"#
done

echo -e '\e[10A\e[K'$background'
'$titleground'\033[;36m'$title'\033[0;38m'$titleground'
'$background'
'$background'
'$background'
'$button12ground''$button1color''$button1'\033[0;38m'$button12ground''$button2color''$button2'\033[0;38m'$button12ground'
'$background'
'$button3ground''$button3color''$button3'\033[0;38m'$button3ground'
'$background'
'$background'\033[0K\r'
read_input
}								#GUI END

read_input () {
escape_char=$(printf "\u1b")
read -rsn1 mode
if [[ "$mode" == "$escape_char" ]]; then
    read -rsn2 mode
fi
case $mode in
    '[B') if [[ "$button3color" == "$default" ]]; then button1color="$default" && button2color="$default" && button3color="$red" ;fi ;gui ;; #down
    '[D') if [[ ! "$button2color" == "$default" ]]; then button2color="$default" && button1color="$green" ;else button3color="$default" && button1color="$green" ;fi ;gui ;; #left
    '[C') if [[ ! "$button1color" == "$default" ]]; then button1color="$default" && button2color="$green" ;else button3color="$default" && button2color="$green";fi ;gui ;; #right
    *) if [[ "$mode" == "" ]]; then output; else gui; fi ;;
esac
}

output () {
if [[ ! "$button1color" == "$default" ]];then echo "button 1"
   else

       if [[ ! "$button2color" == "$default" ]];then echo "button 2" ;else echo "button 3" ;fi
fi
}

#run "gui" for yes/no window
gui
