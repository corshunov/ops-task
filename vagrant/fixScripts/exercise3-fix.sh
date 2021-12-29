#!/bin/bash
#add fix to exercise3 here
sed -i 's/Require all denied/Require all granted/' /etc/apache2/sites-available/000-default.conf
service apache2 reload
