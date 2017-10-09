#!/bin/bash

declare -a arr=("file1" "file2.php" "file3")

echo -n "String to replace:"
read ORIG

echo -n "Replacement string:"
read NEW

for f in "${arr[@]}"
do
    sed -i -e "s/$ORIG/$NEW/g" $f
done
    
