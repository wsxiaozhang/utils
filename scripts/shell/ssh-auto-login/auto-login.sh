#!/bin/bash

host=$1
user=$2
password=$3
interact=$4

if [ $interact = 1 ]
then
    echo "auto login"
    ./auto-login.exp $host $user $password
else
    ssh $user@$host
fi

