#!/bin/bash
image=$(mktemp --suffix=.png)
scrot -o "$image"
value="60" #brightness value to compare to
color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

if [[ $color -gt $value ]]; then #white background image and black text
    param=("--insidecolor=0000001c --ringcolor=0000003e 
        --linecolor=00000000 --keyhlcolor=ffffff80 --ringvercolor=ffffff00 
        --separatorcolor=22222260 --insidevercolor=ffffff1c 
        --ringwrongcolor=ffffff55 --insidewrongcolor=ffffff1c 
        --verifcolor=ffffff00 --wrongcolor=ff000000 --timecolor=ffffff00 
        --datecolor=ffffff00 --layoutcolor=ffffff00 --greetercolor=000000ff")
else #black
    param=("--insidecolor=ffffff1c --ringcolor=ffffff3e 
        --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 
        --separatorcolor=22222260 --insidevercolor=0000001c 
        --ringwrongcolor=00000055 --insidewrongcolor=0000001c 
        --verifcolor=00000000 --wrongcolor=ff000000 --timecolor=00000000 
        --datecolor=00000000 --layoutcolor=00000000 --greetercolor=ffffffff")
fi
echo $param
i3lock-fancy-rapid 5 3 $param --greeter-font=Cantarell --indicator --greetertext "Enter password to unlock"