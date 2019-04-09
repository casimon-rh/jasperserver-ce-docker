#!/bin/bash
STOP_PROC=0;
trap "docker_stop" SIGINT SIGTERM

function docker_stop {
    export STOP_PROC=1;
}
if [ ! -z "$DATABASE_TYPE" ] && [ ! -z "$DATABASE_HOST" ] && [ ! -z "$DATABASE_USER" ] && [ ! -z "$DATABASE_PASS" ]; then
    if [ "$DATABASE_TYPE" = "mysql" ]; then
        cp ./buildomatic/sample_conf/mysql_master.properties ./buildomatic/default_master.properties
    elif [ "$DATABASE_TYPE" = "postgres" ]; then
        cp ./buildomatic/sample_conf/postgresql_master.properties ./buildomatic/default_master.properties
    fi
    sed -i -e "s/^dbHost=localhost/dbHost=$DATABASE_HOST/" \
    -e "s/^dbUsername=postgres/dbUsername=$DATABASE_USER/" \
    -e "s/^dbUsername=root/dbUsername=$DATABASE_USER/" \
    -e "s/^dbPassword=postgres/dbPassword=$DATABASE_PASS/" \
    -e "s/^dbPassword=password/dbPassword=$DATABASE_PASS/" \
    ./buildomatic/default_master.properties

    cd buildomatic
    if [ ! -z "$KEEP_DATA" ]; then 
        echo "n" | ./js-install-ce.sh minimal
    else
        echo "y" | ./js-install-ce.sh minimal
    fi
    cd ..
    rm -f /usr/local/tomcat/webapps/jasperserver/WEB-INF/applicationContext-diagnostic.xml
    sed -i -e "s/^org.owasp.csrfguard.Enabled = true/org.owasp.csrfguard.Enabled = false/" /usr/local/tomcat/webapps/jasperserver/WEB-INF/csrf/jrs.csrfguard.js
    catalina.sh start
else
    echo "no hay entorno"
    docker_stop
fi



EXIT_DAEMON=0

while [ $EXIT_DAEMON -eq 0 ]; do
    if [ $STOP_PROC != 0 ]
    then
        break;
    fi
    sleep 5
done