#!/bin/bash
#add fix to exercise5-server2 here
keyspath="/vagrant/keys"

cp "$keyspath/server2" /home/vagrant/server2_key
chown vagrant:vagrant /home/vagrant/server2_key
chmod 600 /home/vagrant/server2_key

cat "$keyspath/server1.pub" >> /home/vagrant/.ssh/authorized_keys

cp "$keyspath/server2" /root/server2_key
chown root:root /root/server2_key
chmod 600 /root/server2_key

cat "$keyspath/server1.pub" >> /root/.ssh/authorized_keys

sed -i '/Include/a Host server1 192.168.100.10\nStrictHostKeyChecking no\nPasswordAuthentication no\nIdentityFile ~/server2_key\nIdentitiesOnly yes' /etc/ssh/ssh_config
service ssh restart

rm -rf "$keyspath"
