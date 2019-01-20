#!/bin/bash
# simple script to query the existence of specific Oracle jdk executable, if installed.
#
# @return: JSON string : { "found": true/false, "not_found": true/false }

export LC_ALL="en_US.UTF-8" 

PACKAGE="\"$1\""

line=$(java -version 2>&1  | grep ${PACKAGE} | grep -iv openjdk | wc -l)

if [[ ${line} =~ 0 ]]; then
  echo '{ "found": false , "not_found": true  }'

else
  echo '{ "found": true  , "not_found": false }'

fi
