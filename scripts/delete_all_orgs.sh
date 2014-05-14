#!/bin/bash

knife=$1

for org in $(../bin/knife opc -c $knife org list); do
   yes | ../bin/knife opc -c $knife org delete $org
done
