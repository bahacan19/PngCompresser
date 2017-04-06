#!/bin/bash



if [ -z "$1" ]
then
echo -e  $'\e[31m
No input directory set.
Usage :
png_press.sh ${input directory full path} ${output directory full path}'
echo $'\e[0m'
exit
fi

if [ -z "$2" ]
then
echo -e  $'\e[31m
No output directory set.
Usage :
png_press.sh ${input directory full path} ${output directory full path}'
echo $'\e[0m'
exit
fi

if ! type  zopflipng>/dev/null 2>&1; then
    echo "zopfli not found in this machine \n" 1>&2
    git clone https://github.com/google/zopfli.git
    cd zopfli
    make zopflipng
    directory=${PWD}

        if grep -q '\nexport PATH="'${directory}':$PATH"' ~/.bash_profile; ##note the space after the string you are searching for
          then
        echo "zopflipng is available on path"
        else
        echo $'\nexport PATH="'${directory}':$PATH"' >>~/.bash_profile
        fi

else
    echo "zopflipng found in this machine"
fi

mkdir -p $2
for file in "$1"/*.png
do
    zopflipng "${file}" -m $2/$(basename "${file}")
done


