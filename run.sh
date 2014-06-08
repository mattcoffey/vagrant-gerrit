#!/bin/bash
#===============================================================================
#
#          FILE:  run.sh
# 
#         USAGE:  ./run.sh 
# 
#   DESCRIPTION:  Run the Gerrit container
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Matt Coffey (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  06/07/14 20:04:25 BST
#      REVISION:  ---
#===============================================================================

docker run -p 127.0.0.1:8080:8080 -p 127.0.0.1:29418:29418 mcoffey/gerrit $*
