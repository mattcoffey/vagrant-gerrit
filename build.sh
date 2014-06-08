#!/bin/bash
#===============================================================================
#
#          FILE:  build.sh
# 
#         USAGE:  ./build.sh 
# 
#   DESCRIPTION:  Build the container
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Matt Coffey (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  06/07/14 20:03:03 BST
#      REVISION:  ---
#===============================================================================

docker rmi mcoffey/gerrit
docker build -rm -t mcoffey/gerrit .
