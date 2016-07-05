#!/bin/bash
#
set -x
DRIVER_DIR="/var/lib/irods/iRODS/server/bin/cmd"
DRIVER="univMSSInterface_generic.sh"
LOCAL_TEST_DIR="/tmp"
REMOTE_TEST_DIR="/pnfs/grid.sara.nl/data/irods/robert_test_dir"

# create test file
echo "this is a very small testfile" > $LOCAL_TEST_DIR/test.txt

# copy file to dCache via gridftp
${DRIVER_DIR}/${DRIVER} syncToArch $LOCAL_TEST_DIR/test.txt ${REMOTE_TEST_DIR}/test.txt
echo $?

# give status of file:
${DRIVER_DIR}/${DRIVER} stat ${REMOTE_TEST_DIR}/test.txt
echo $?

# retrieve file from dCache and check if it is the same
${DRIVER_DIR}/${DRIVER} stageToCache ${REMOTE_TEST_DIR}/test.txt $LOCAL_TEST_DIR/test1.txt
echo $?
diff $LOCAL_TEST_DIR/test.txt $LOCAL_TEST_DIR/test1.txt
echo $?

# create directory and remove it again
${DRIVER_DIR}/${DRIVER} mkdir ${REMOTE_TEST_DIR}/subdir1/subdir2
echo $?
${DRIVER_DIR}/${DRIVER} stat ${REMOTE_TEST_DIR}/subdir1/subdir2
echo $?
${DRIVER_DIR}/${DRIVER} rm ${REMOTE_TEST_DIR}/subdir1/subdir2
echo $?
${DRIVER_DIR}/${DRIVER} stat ${REMOTE_TEST_DIR}/subdir1/subdir2
echo $?
${DRIVER_DIR}/${DRIVER} rm ${REMOTE_TEST_DIR}/subdir1
echo $?
${DRIVER_DIR}/${DRIVER} stat ${REMOTE_TEST_DIR}/subdir1
echo $?

# move file in dCache
${DRIVER_DIR}/${DRIVER} mv ${REMOTE_TEST_DIR}/test.txt ${REMOTE_TEST_DIR}/test1.txt
echo $?

# remove file
${DRIVER_DIR}/${DRIVER} rm ${REMOTE_TEST_DIR}/test1.txt
echo $?

# remove file again. This should fail.
${DRIVER_DIR}/${DRIVER} rm ${REMOTE_TEST_DIR}/test1.txt
echo $?
