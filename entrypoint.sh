#!/bin/sh
MINIO_ACCESS_KEY=`cat /var/run/secrets/minio/ACCESS_KEY`
MINIO_SECRET_KEY=`cat /var/run/secrets/minio/SECRET_KEY`
export MINIO_ACCESS_KEY
export MINIO_SECRET_KEY
#MINIO_SERVER_LIST="http://minio-docker-0.minio-docker.infinity-dev.svc.cluster.local:9000/minio-data http://minio-docker-1.minio-docker.infinity-dev.svc.cluster.local:9000/minio-data http://minio-docker-2.minio-docker.infinity-dev.svc.cluster.local:9000/minio-data http://minio-docker-3.minio-docker.infinity-dev.svc.cluster.local:9000/minio-data"
MINIO_SERVER_LIST="http://minio-docker-{0...3}.minio-docker.${KUBERNETES_NAMESPACE}.svc.cluster.local:9000/minio-data"
/minio server $MINIO_SERVER_LIST 2>&1 &
sleep 60
while true; do /mc config host add local http://localhost:9000 $MINIO_ACCESS_KEY $MINIO_SECRET_KEY ; /mc policy download local/public-downloads && mc admin info local; sleep 60; done;
