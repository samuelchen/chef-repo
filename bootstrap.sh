#!/bin/sh

IP=$1
NAME=$2
RECIPE=$3
JSON=$4

cmd="knife bootstrap $IP -x root -P passw0rd --bootstrap-template ./bootstrap/chef-full.erb -y "

if [ -n "$NAME" ]; then
  cmd="$cmd -N $NAME"
fi

if [ -n "$RECIPE" ]; then
  cmd="$cmd -r recipe[$RECIPE]"
fi

if [ -n "$JSON" ]; then
  #attr=`cat $JSON`
  attr=`awk -v RS="" '{gsub("\n","");print}' $JSON`
  cmd="$cmd -j '$attr'"
  #cmd="$cmd -j $JSON"
fi

echo "$cmd"
$cmd
