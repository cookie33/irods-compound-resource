#!/bin/bash
#
set -x

LOCAL_TEST_DIR="/tmp"
IRODS_TEST_DIR="/vzSARA1/home/rods/test"


# create test file
echo "this is a very small testfile" > $LOCAL_TEST_DIR/test.txt

# copy file to dCache via gridftp
iput $LOCAL_TEST_DIR/test.txt ${IRODS_TEST_DIR}/test.txt
echo $?

# give status of file:
ils -l ${IRODS_TEST_DIR}/test.txt
echo $?

# wait 2*60 seconds for copy to be done
sleep 120

# give status of file:
ils -l ${IRODS_TEST_DIR}/test.txt
echo $?

# retrieve file from dCache and check if it is the same
iget -f ${IRODS_TEST_DIR}/test.txt $LOCAL_TEST_DIR/test1.txt
echo $?
diff $LOCAL_TEST_DIR/test.txt $LOCAL_TEST_DIR/test1.txt
echo $?

# create directory and remove it again
imkdir -p ${IRODS_TEST_DIR}/subdir1/subdir2
echo $?
ils ${IRODS_TEST_DIR}/subdir1/subdir2
echo $?
irm -r ${IRODS_TEST_DIR}/subdir1/subdir2
echo $?
ils ${IRODS_TEST_DIR}/subdir1/subdir2
echo $?
irm -r ${IRODS_TEST_DIR}/subdir1
echo $?
ils ${IRODS_TEST_DIR}/subdir1
echo $?

# move file in dCache
imv ${IRODS_TEST_DIR}/test.txt ${IRODS_TEST_DIR}/test1.txt
echo $?

# wait 2*60 seconds for copy to be done
sleep 120

# remove file
irm ${IRODS_TEST_DIR}/test1.txt
echo $?

# remove file again. This should fail.
irm ${IRODS_TEST_DIR}/test1.txt
echo $?
