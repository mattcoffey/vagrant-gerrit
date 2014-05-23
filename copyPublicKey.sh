#!/bin/bash
#===============================================================================
#
#          FILE:  copyPublicKey.sh
# 
#         USAGE:  ./copyPublicKey.sh 
# 
#   DESCRIPTION:  Copy your SSH public key to clipboard
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Matt Coffey (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  05/22/14 11:53:34 BST
#      REVISION:  ---
#===============================================================================

pbcopy < ~/.ssh/id_rsa.pub
