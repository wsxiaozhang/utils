#!/bin/bash

if [ $# -eq 1 ]; then
  commands=$1
else
  commands="ip a | grep eth0"
fi

function rootLogin()
{
  host=$1
  user="root"
  echo "commands=" ${commands}
  if [ $# -eq 2 ]; then
    password=$2
    ./auto-login.exp $host $user $password $commands
  else
    ssh $user@$host $commands
  fi  
}

if [ -s hosts.txt ]; then
  for i in `cat hosts.txt`
  do
    ip=$(echo "$i" | cut -f1 -d ":")
    password=$(echo "$i" | cut -f2 -d ":")
    echo "login ${ip} now ..."
    rootLogin $ip $password
  done
fi

