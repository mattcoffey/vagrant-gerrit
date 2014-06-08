#!/bin/bash 
#=============================================================================== 
# 
#          FILE:  deploy_docker.sh 
#  
#         USAGE:  ./deploy_docker.sh -i $ipAddress -h $hostname
#  
#   DESCRIPTION: Install Docker on CentOS, optionally, this can 
#                set a hostname in /etc/hosts
#  
#       OPTIONS:  -i the IP address
#                 -h the hostname 
#  REQUIREMENTS:  --- 
#          BUGS:  --- 
#         NOTES:  --- 
#        AUTHOR:  Matt Coffey (),  
#       COMPANY:   
#       VERSION:  1.0 
#       CREATED:  02/06/14 20:10:59 GMT 
#      REVISION:  --- 
#=============================================================================== 

echo "Running deploy_docker.sh"

if [[ -f /etc/provisioned ]];
then
    echo "Provisioned on:"
    echo "cat $(/etc/provisioned)"
    echo "Skipping deploy_docker.sh..."
    exit 0
fi

echo "Provisioned on $(date)" > /etc/provisioned

while getopts i:h: option 
do 
    case "${option}" 
    in 
        i) IP=$OPTARG;; 
        h) HOST=$OPTARG;; 
    esac 
done

# Add this hostname to /etc/hosts if IP and hostname have been specified
if [[ ! -z "$IP" && ! -z "$HOST" ]];
then
    echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4\n" > /etc/hosts
    echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6\n" >> /etc/hosts 
    echo "$IP $HOST $HOST" >> /etc/hosts
fi

# Install dependencies
yum -y update
yum install -y git gcc pcre-devel openssl-devel

rpm -Uhv --force http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
yum install -y postgresql93

# Install and start Docker
rpm -Uvh --force http://mirrors.kernel.org/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install docker-io

service docker start
chkconfig docker on

# Invoke docker to indicate whether this script was successful
docker -v >/dev/null

# Check whether the docker command executed successfully
if [[ $? -ne 0 ]];
then
    echo "Docker failed to install"
    exit 1
fi

echo "                        ##        ." > /etc/motd
echo "                  ## ## ##       ==" >> /etc/motd
echo "               ## ## ## ##      ===" >> /etc/motd
echo '           /""""""""""""""""\___/ ===' >> /etc/motd
echo "      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~" >> /etc/motd
echo "           \______ o          __/" >> /etc/motd
echo "             \    \        __/" >> /etc/motd
echo "              \____\______/" >> /etc/motd
echo "" >> /etc/motd
echo "              |          |" >> /etc/motd
echo "           __ |  __   __ | _  __   _" >> /etc/motd
echo "          /  \| /  \ /   |/  / _\ |" >> /etc/motd
echo "          \__/| \__/ \__ |\_ \__  |" >> /etc/motd

echo "Docker installed successfully"
exit 0
