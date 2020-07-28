FROM alpine:3.12.0
VOLUME ["/minio-data"]
ARG DIRLIST="/minio-data /.mc"
RUN mkdir -p ${DIRLIST} && chgrp -Rf root ${DIRLIST} && chmod -Rf g+w  ${DIRLIST} 
ADD entrypoint.sh /tmp/
ADD config.json /tmp/
RUN chmod g+x /tmp/entrypoint.sh && chgrp root /tmp/entrypoint.sh 
RUN apk update && apk add --no-cache wget
RUN wget http://dl.minio.io/client/mc/release/linux-amd64/mc && chmod g+x  mc && ./mc --help && pwd
ENV PATH=${PATH}:/
WORKDIR /
RUN wget https://dl.minio.io/server/minio/release/linux-amd64/minio && \
 chmod g+x /minio
ENTRYPOINT /tmp/entrypoint.sh
EXPOSE 9000

