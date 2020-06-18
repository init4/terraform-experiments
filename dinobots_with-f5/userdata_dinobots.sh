#!/bin/bash -v

: '
Copyright 2019 F5 Networks Inc.
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
'

sudo yum install -y nginx 
#sudo yum install -y gcc python27 python27-devel python27-pip libffi-devel openssl-devel git nginx 
#
#sudo /usr/bin/pip-2.7 install --upgrade ansible
#
#sudo /usr/bin/pip-2.7install ansible-lint
#
#sudo /usr/bin/pip-2.7 install ansible-review 
#
#sudo /usr/bin/pip-2.7 install bigsuds
#
#sudo /usr/bin/pip-2.7 install f5-sdk
#
#cd /home/ec2-user
#
#/usr/bin/wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

sudo service nginx start

#sudo yum install -y tomcat8
#
#cd /usr/share/tomcat8/webapps
#
#sudo /usr/bin/wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bodgeit/bodgeit.1.4.0.zip
#
#sudo unzip bodgeit.1.4.0.zip
#
#sudo service tomcat8 start

export IP=`ip -br -4 addr show dev eth0 |awk '{print $3}'` 
echo $IP

if [ $IP = "10.0.2.101/24" ];
then
  self=slag
elif [ $IP = "10.0.2.102/24" ];
then
  self=sludge
elif [ $IP = "10.0.2.103/24" ];
then
  self=snarl
elif [ $IP = "10.0.2.104/24" ];
then
  self=swoop
fi
echo $self

cd /usr/share/nginx/html
sudo chown ec2-user .
sudo mv index.html index.html.old
/usr/bin/wget http://shockwave.init4.org/dinobots_html.tgz
sudo tar zxf dinobots_html.tgz
ln -s $self.html index.html
 
