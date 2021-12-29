#!/bin/bash
#add fix to exercise5-server1 here
keyspath="/vagrant/keys"
if [[ -d "$keyspath" ]]; then rm -rf "$keyspath"; fi
mkdir "$keyspath"

ssh-keygen -b 4096 -t rsa -f "$keyspath/server1" -q -N "" -C ""
ssh-keygen -b 4096 -t rsa -f "$keyspath/server2" -q -N "" -C ""

cp "$keyspath/server1" /home/vagrant/server1_key
chown vagrant:vagrant /home/vagrant/server1_key
chmod 600 /home/vagrant/server1_key

cat "$keyspath/server2.pub" >> /home/vagrant/.ssh/authorized_keys

cp "$keyspath/server1" /root/server1_key
chown root:root /root/server1_key
chmod 600 /root/server1_key

cat "$keyspath/server2.pub" >> /root/.ssh/authorized_keys

sed -i '/Include/a Host server2 192.168.100.11\nStrictHostKeyChecking no\nPasswordAuthentication no\nIdentityFile ~/server1_key\nIdentitiesOnly yes' /etc/ssh/ssh_config
service ssh restart
