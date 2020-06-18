#!/bin/bash
#
# TODO
# - install ntp, dns servers 
# - install default route?
# - install as3 and ts rpms
# - provision asm
# - attach basic waf policy
# - provision afm
# - attach basic firewall policy

echo "firstrun debug: initalising cloud-init" >> /var/tmp/cloud-init-output
logger -p local0.info 'firstrun debug: initialising cloud-init'

# Wait for MCPD to be up before running tmsh commands
source /usr/lib/bigstart/bigip-ready-functions
wait_bigip_ready

# System settings 
logger -p local0.info 'firstrun debug: setting base config'
tmsh modify sys global-settings gui-setup disabled
tmsh modify auth password-policy policy-enforcement disabled
tmsh modify auth user admin password \"p4ssw0rd\"
tmsh modify auth user admin { password p4ssw0rd }
tmsh modify auth user admin shell bash
tmsh modify sys http auth-pam-validate-ip off

# Configure the network
logger -p local0.info 'firstrun debug: configuring network'
tmsh create net vlan external interfaces add { 1.1 { untagged } }
tmsh create net self 10.0.1.10 address 10.0.1.10/24 vlan external allow-service default
tmsh create net vlan internal interfaces add { 1.2 { untagged } }
tmsh create net self 10.0.2.10 address 10.0.2.10/24 vlan internal allow-service default
#tmsh create net route default network 0.0.0.0 gateway 10.0.1.1

# Configure app
#logger -p local0.info 'firstrun debug: configuring app'
#tmsh create ltm pool p_app2_http monitor http members add { 10.0.2.101:80 10.0.2.102:80 10.0.2.103:80 10.0.2.104:80 } 
#tmsh create ltm virtual vs_app2_http destination 10.0.1.100:8080 profiles add { f5-tcp-progressive http } source-address-translation { type automap } pool p_app2_http 

tmsh save sys config

# Install AS3 and TS packages
cd /var/config/rest/downloads/ 
curl -OL https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.20.0/f5-appsvcs-3.20.0-3.noarch.rpm
curl -OL https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.12.0/f5-telemetry-1.12.0-3.noarch.rpm
#rpm -ivh /tmp/f5-appsvcs-3.20.0-3.noarch.rpm
#rpm -ivh /tmp/f5-telemetry-1.12.0-3.noarch.rpm

