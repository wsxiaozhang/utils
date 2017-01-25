#!/bin/bash
while read ips;
do
    echo $ips;
    upt=`ssh -n root@$ips "uptime"`;
    echo $upt;
done < ip.txt

for ips in `cat ip.txt`; do
       echo ${ips};
       upt=`ssh root@${ips} uptime`;
       echo $upt;
done

for dst_ip in  `cat list2`;do
    ssh -p22 root@$dst_ip 'service iptables restart';
done




