#!/bin/bash

users=$(../bin/knife opc -c ../work/knife-opc.rb user list)

echo $users

for user in $users; do
  if [[ 'applejack fleetfoot fluttershy pinkiepie pivotal rapidfire rarity soarin spitfire twilightsparkle' =~ $user ]]; then    
    echo "Don't want to delete $user. Skipping..."
  else
    echo "Deleting $user"
    yes | ../bin/knife opc -c ../work/knife-opc.rb user delete $user
  fi
done
