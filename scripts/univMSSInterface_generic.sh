#!/bin/sh

#set -x

## Copyright (c) 2009 Data Intensive Cyberinfrastructure Foundation. All rights reserved.
## For full copyright notice please refer to files in the COPYRIGHT directory
## Written by Jean-Yves Nief of CCIN2P3 and copyright assigned to Data Intensive Cyberinfrastructure Foundation

# This script is a generic script which must be updated if one wants to use the universal MSS driver.
# Your working version should be in this directory server/bin/cmd/univMSSInterface.sh.
# Functions to modify: syncToArch, stageToCache, mkdir, chmod, rm, stat
# These functions need one or two input parameters which should be named $1 and $2.
# If some of these functions are not implemented for your MSS, just let this function as it is.
#
# modify the "ACCESS" parameter to choose the univMSSInterface[_access_method].sh to start.
# if the default is used the default iRODS supplied univMSSInterface.sh will be started.
# this script has to be put in the same directory as the univMSSInterface.sh
# 
# the iRODS archive resource has to call the univMSSInterface_generic.sh instead of
# univMSSInterface.sh in the compound resource

# Changelog:
# 2016-07-01 - v1.00 - RV - create initial univMSSInterface_generic.sh from univMSSInterface.sh

VERSION=v1.00
PROG=`basename $0`
FILEPATH=`dirname $0`

############# Customer paramater start
# ACCESS="" # default so standard univMSSInterface.sh is used.
ACCESS="_gridftp" # access for SURFsara.
############# Customer paramater end

#############################################
# below this line, nothing should be changed.
#############################################

univMSSInterface="${FILEPATH}/univMSSInterface${ACCESS}.sh"

case "$1" in
	syncToArch )   $univMSSInterface $1 $2 $3 ;;
	stageToCache ) $univMSSInterface $1 $2 $3 ;;
	mkdir ) $univMSSInterface $1 $2 ;;
	chmod ) $univMSSInterface $1 $2 $3 ;;
	rm )    $univMSSInterface $1 $2 ;;
	mv )    $univMSSInterface $1 $2 $3 ;;
	stat )  $univMSSInterface $1 $2 ;;
esac

exit $?
