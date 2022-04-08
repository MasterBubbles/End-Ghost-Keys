#!/bin/bash

# Recuperating lines from input file and deleting them
head -n 1 keys.ini > line1D
head -n 1 keys.ini > line1U
sed -i '1d' keys.ini

head -n 1 keys.ini > line2D
head -n 1 keys.ini > line2U
sed -i '1d' keys.ini

head -n 1 keys.ini > line3D
head -n 1 keys.ini > line3U
sed -i '1d' keys.ini

head -n 1 keys.ini > line4D
sed -i '1d' keys.ini

# Creating 2 new macros (one for event DOWN and one for event UP)

sed -i 's/..$//' line1D
sed -i 's/$/_D]/' line1D

sed -i 's/..$//' line1U
sed -i 's/$/_U]/' line1U

# Replacing trigger with +1 at last number for UP event macro

str0=`cat line3U`
str1=`echo $str0 | sed -e 's/.*\(..\)$/\1/'`
str1=$(echo "$str1" | tr -d $'\r')

line3Ux=`sed 's/..$//' line3U`
line3Uy=`echo 1+"$str1" | bc`
echo "$line3Ux$line3Uy" > line3U

# Replacing UP event with ShiftUp,AltUp,CtrlUp
echo "combo=2a,0,1|36,0,1|38,0,1|38,0,3|1d,0,1|1d,0,3|" > line4U

# Creating the output file if it doesn't already exist
touch output_keys.ini

# Output each line individually
cat line1D >> output_keys.ini
cat line2D >> output_keys.ini
cat line3D >> output_keys.ini
cat line4D >> output_keys.ini
cat line1U >> output_keys.ini
cat line2U >> output_keys.ini
cat line3U >> output_keys.ini
cat line4U >> output_keys.ini

