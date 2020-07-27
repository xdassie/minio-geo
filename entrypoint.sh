#!/bin/sh
MINIO_ACCESS_KEY=`cat /var/run/secrets/minio/ACCESS_KEY`
MINIO_SECRET_KEY=`cat /var/run/secrets/minio/SECRET_KEY`
export MINIO_ACCESS_KEY
export MINIO_SECRET_KEY
/minio server SERVER_LIST 2>&1 &
sleep 60
while true; do /mc config host add local http://localhost:9000 $MINIO_ACCESS_KEY $MINIO_SECRET_KEY ; /mc policy download local/public-downloads && mc admin info local; sleep 60; done;
