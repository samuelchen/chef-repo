#!/bin/sh

IP=$1
NAME=$2
RECIPE=$3

echo "knife bootstrap $IP -x root -P passw0rd --bootstrap-template ./bootstrap/chef-full.erb -N $NAME -r recipe[$RECIPE] -y"
knife bootstrap $IP -x root -P passw0rd --bootstrap-template ./bootstrap/chef-full.erb -N $NAME -r recipe[$RECIPE] -y
