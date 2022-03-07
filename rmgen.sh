#!/bin/bash

OUTPUT_PATH=$PWD"/"

while getopts ":o:n:" FLAG; do
    case $FLAG in
        o)
            OUTPUT_PATH+=${OPTARG}"/" ;;
        n)
            NUM=${OPTARG} ;;
        *)
            echo "Unknown arguments given. Exiting."
            exit 1
    esac
done

if [ ! -d $OUTPUT_PATH ]
then
    echo "Invalid path."
    exit 1
fi

OUT=$OUTPUT_PATH"README.txt"

if [ -f $OUT ]
then
    while true; do
        read -p "File exists, overwrite? [Y/n]" OVERWRITE
        case $OVERWRITE in
            [Nn])
                exit 0 ;;
            "")
                break ;;
            [Yy])
                break ;;
            *)
                echo "Please answer Y/N"
        esac
    done
fi

echo "Homework "$NUM > $OUT
echo "" >> $OUT
{ echo "Editor:            "; nvim -v | sed 1q | sed 's/NVIM/Neovim/'; } | tr "\n" " " >> $OUT
echo "" >> $OUT
{ echo "Lisp:              "; clisp --version | sed 1q | cut -d " " -f1-3; } | tr "\n" " " >> $OUT
echo "" >> $OUT
{ echo "Environment:        Gentoo/kernel-version:"; uname -r | cut -d "-" -f1; } | tr "\n" " " >> $OUT
echo "" >> $OUT
{ echo "Terminal Emulator:  Alacritty"; alacritty --version | cut -d " " -f2; } | tr "\n" " " >> $OUT
echo "" >> $OUT
{ echo "Shell:             "; zsh --version | cut -d " " -f1-2; } | tr "\n" " " >> $OUT
echo "" >> $OUT
echo "Author:             Colson Xu (cx2336)" >> $OUT
echo "" >> $OUT

