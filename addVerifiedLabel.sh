#!/bin/bash
#===============================================================================
#
#          FILE:  addVerifiedLabel.sh
# 
#         USAGE:  ./addVerifiedLabel.sh
# 
#   DESCRIPTION:  Add Verified Label to All-Projects
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Matt Coffey (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  05/22/14 12:18:31 BST
#      REVISION:  ---
#===============================================================================

mkdir tmp
cd tmp
git init
git remote add origin ssh://mcoffey@172.28.128.2:29418/All-Projects
git fetch origin refs/meta/config:refs/remotes/origin/meta/config
git checkout meta/config
echo '[label "Verified"]
       function = MaxWithBlock
       value = -1 Fails
       value =  0 No score
       value = +1 Verified' >> project.config
git commit -am "Added Verified to All-Projects"
git push origin meta/config:meta/config
rm -rf tmp
