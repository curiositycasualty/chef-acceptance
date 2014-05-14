#!/bin/bash

for org in $(../bin/knife opc -c ../work/knife-opc.rb org list); do
   yes | ../bin/knife opc -c ../work/knife-opc.rb org delete $org
done
