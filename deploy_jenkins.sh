#!/bin/bash
#===============================================================================
#
#          FILE:  deploy_jenkins.sh
# 
#         USAGE:  ./deploy_jenkins.sh 
# 
#   DESCRIPTION: Install and configure Jenkins on CentOS 6 
#                Assumes Java is already installed
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Matt Coffey (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  05/22/14 13:55:38 BST
#      REVISION:  ---
#===============================================================================

wget --quiet --no-check-certificate -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum -y install jenkins
service jenkins start
chkconfig jenkins on
