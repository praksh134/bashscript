#!/bin/bash

###############
# for loops 1 #
###############

# looping the file list

for i in $(cat for-loops-list.txt);
do
	echo "the users are: $i"
done
