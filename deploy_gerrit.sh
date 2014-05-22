#!/bin/bash 
#=============================================================================== 
# 
#          FILE:  deploy_gerrit.sh 
#  
#         USAGE:  ./deploy_gerrit.sh  
#  
#   DESCRIPTION: Install and configure Gerrit on CentOS 6
#  
#       OPTIONS:  --- 
#  REQUIREMENTS:  --- 
#          BUGS:  --- 
#         NOTES:  --- 
#        AUTHOR:  Matt Coffey (),  
#       COMPANY:   
#       VERSION:  1.0 
#       CREATED:  05/09/14 13:23:13 GMT 
#      REVISION:  --- 
#=============================================================================== 

if [[ -f /etc/deploy ]];
then
    echo "Provisioned before on:"
    echo cat /etc/deploy
    echo "Skipping deploy_gerrit.sh..."
    exit 0
fi

timestamp="(date + "%T")"

echo "Provisioned on $timestamp" > /etc/deploy

while getopts i:h: option 
do 
        case "${option}" 
        in 
                i) IP=$OPTARG;; 
                h) HOSTNAME=$OPTARG;; 
        esac 
done

# Add this host to firewall
echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4\n" > /etc/hosts
echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts 
echo "$IP $HOSTNAME $HOSTNAME" >> /etc/hosts

# Drop firewall TODO configure firewall instead
service iptables stop
# Install Java
rpm -ivh http://javadl.sun.com/webapps/download/AutoDL?BundleId=80804
# Install Git
yum -y install git
# Create gerrit2 user
sudo adduser gerrit2 

# Download Gerrit
wget --quiet --no-check-certificate https://gerrit-releases.storage.googleapis.com/gerrit-2.8.5.war  -O - >> /tmp/gerrit.war
chmod 555 /tmp/gerrit.war

# Initialise and start Gerrit
su - gerrit2 -c "java -jar /tmp/gerrit.war init --batch -d ~/gerrit"

exit 0;
