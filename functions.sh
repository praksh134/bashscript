#!/bin/bash

####################
# funtions in bash #
####################

# add function in bash

add()
{

	echo "Enter your first number: "
	read num1

	echo "Enter your second number: "
	read num2

	res=$(($num1 + $num2))

	echo "Your answer is $res"

}

add
