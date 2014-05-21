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
    echo "Deployment script has been run before on:"
    echo cat /etc/deploy
    echo "Skipping..."
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

echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4\n" > /etc/hosts
echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts 
echo "$IP $HOSTNAME $HOSTNAME" >> /etc/hosts

sudo su
service iptables stop 
rpm -ivh http://javadl.sun.com/webapps/download/AutoDL?BundleId=80804 
yum -y install git
sudo adduser gerrit2 
sudo su gerrit2 
wget --quiet --no-check-certificate https://gerrit-releases.storage.googleapis.com/gerrit-2.8.5.war 
java -jar gerrit-2.8.5.war init --batch -d ~/gerrit

exit 0;
~                                                                                                                                     
~                                                   
