#!/bin/bash

if [ -s hosts-with-user.txt ]; then  
  for p in $(cat "hosts-with-user.txt")  #   
  do  
    username=$(echo "$p"|cut -f1 -d":") # Get username   
    ip=$(echo "$p"|cut -f2 -d":")       # Get ip    
    password=$(echo "$p"|cut -f3 -d":") # Get password   
    id=$HOME/.ssh/id_rsa.pub  
    if [ $(ls $id) ]; then 
      echo "ssh-copy-id -i $id  $username@$ip -P $password"  
      # ssh-copy-id  
      PASSWORD=$password expect -c "  
      spawn ssh-copy-id -i $id  $username@$ip  
        expect {  
          "*yes/no*" 
          {
             send -- "yes\r"; exp_continue
          }  
          "*password*"
          {
             send -- \$env(PASSWORD)\r; exp_continue
          }  
          "*Password*" 
          {
             send -- \$env(PASSWORD)\r}
          }  
          
      "
    fi  
  done  
fi
