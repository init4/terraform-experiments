#!/bin/bash -v
#
sudo yum install -y nginx 
sudo service nginx start

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
 
