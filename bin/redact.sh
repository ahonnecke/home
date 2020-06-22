#!/bin/bash

# Prep: Use imagificate.sh to break pdfs into images

# Usage ./redact.sh
# Change to red or something vibrant to play with sizes

for i in *1.png; do
    #Draw a white rectangle in the upper left, one line high
    mogrify -fill white -draw 'rectangle  0,590 900,625' "$i"
    #Draw a white rectangle in the upper right, one line high
    mogrify -fill white -draw 'rectangle  1800,235 2075,300' "$i"
done

for i in *2.png; do
    #Draw a white rectangle in the upper right, one line high
    mogrify -fill white -draw 'rectangle  1800,235 2062,300' "$i"
done

for i in *3.png; do
    #Draw a white rectangle in the upper right, one line high
    mogrify -fill white -draw 'rectangle  1800,235 2062,300' "$i"
done

for i in *4.png; do
    #Draw a white rectangle in the upper right, one line high
    mogrify -fill white -draw 'rectangle  1800,235 2072,300' "$i"
done

# TODO bundle the pngs back into PDFs
