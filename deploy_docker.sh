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

echo "Installing wget..."
yum install wget <<EOF
y
EOF

echo "Installing Docker"
yum install docker-io <<EOF
y
EOF

echo 'other_args="-H tcp://0.0.0.0:4243"' >> /etc/sysconfig/docker
service docker restart
echo 'export DOCKER_HOST=tcp://0.0.0.0:4243' >> /home/vagrant/.bashrc
echo 'alias docker="sudo docker -H $DOCKER_HOST"' >> /home/vagrant/.bashrc

echo "Starting Docker Daemon"
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
