#!/bin/bash

if [ -f run.conf ]
then
	. ./run.conf
fi

docker pull 10.1.1.30:5000/$SERVER_IMAGE

porta=${PWD##*/} | cut -d'-' -f 3

docker run -it -p $porta:8080  \
-v $PWD/deployments/:/antara/jboss/standalone/deployments/ \
-v $PWD/nfe/template:/antara/nfe/template \
-e "MEMORIA_MAXIMA=-Xmx1024m" \
-e "jboss_datasource_connectionurl=$DATABASE_URL" \
-e "jboss_datasource_driver=$DATABASE_DRIVER" \
-e "jboss_datasource_username=$DATABASE_USER" \
-e "jboss_datasource_password=$DATABASE_PASS" \
10.1.1.30:5000/$SERVER_IMAGE

