#!/bin/bash

if [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then
	. .colors
	if [ "${args}" != "" ]; then
		echo -e "${green}${args}${none}"
	fi
	echo -e "${blue}${description}${none}"
	exit 0
elif [ "${1}" == ".args" ]; then
	echo "${args}"
	exit 0
elif [ "${1}" == ".description" ]; then
	echo "${description}"
	exit 0
fi

_suppliedArgumentCount=$#
_command="${0}"

function requires
{
	if [ $# -eq 2 ] && [ "${2}" == "arguments" ]; then
		if [ ${_suppliedArgumentCount} -lt ${1} ]; then
			"${0}" --help
			exit 1
		fi
	else
		echo "Invalid requires $*" >&2
		exit 1
	fi
}
