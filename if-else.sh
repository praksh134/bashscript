#!/bin/bash

####################
# if, else in bash #
####################

echo "Enter your user name: "
read name

if [[ $name == 'prakash' ]];
then

	echo "Welcome $name!"

else
	echo 'Invalid user!'

fi
