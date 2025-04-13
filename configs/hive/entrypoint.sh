#!/bin/sh

set -x

: ${DB_DRIVER:=derby}

SKIP_SCHEMA_INIT="${IS_RESUME:-false}"

# Set up classpath with explicit ordering
export CLASSPATH=$HIVE_HOME/lib/hadoop-client-runtime-3.3.6.jar:\
$HIVE_HOME/lib/hadoop-client-3.3.6.jar:\
$HIVE_HOME/lib/hadoop-common-3.3.6.jar:\
$HIVE_HOME/lib/hadoop-aws-3.3.6.jar:\
$HIVE_HOME/lib/aws-java-sdk-bundle-1.12.262.jar:\
$HIVE_HOME/lib/guava-27.0-jre.jar:\
$CLASSPATH


function initialize_hive {
  $HIVE_HOME/bin/schematool -dbType $DB_DRIVER -initSchema
  if [ $? -eq 0 ]; then
    echo "Initialized schema successfully.."
  else
    echo "Schema initialization failed!"
    exit 1
  fi
}

export HIVE_CONF_DIR=$HIVE_HOME/conf
if [ -d "${HIVE_CUSTOM_CONF_DIR:-}" ]; then
  find "${HIVE_CUSTOM_CONF_DIR}" -type f -exec \
    ln -sfn {} "${HIVE_CONF_DIR}"/ \;
  export HADOOP_CONF_DIR=$HIVE_CONF_DIR
  export TEZ_CONF_DIR=$HIVE_CONF_DIR
fi

export HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Xmx1G $SERVICE_OPTS"
if [[ "${SKIP_SCHEMA_INIT}" == "false" ]]; then
  #Check schema initialization
  $HIVE_HOME/bin/schematool -dbType postgres -info
  if [ $? -eq 1 ]; then
    # handles schema initialization
    initialize_hive
  fi
fi

if [ "${SERVICE_NAME}" == "hiveserver2" ]; then
  export HADOOP_CLASSPATH=$TEZ_HOME/*:$TEZ_HOME/lib/*:$HADOOP_CLASSPATH
elif [ "${SERVICE_NAME}" == "metastore" ]; then
  export METASTORE_PORT=${METASTORE_PORT:-9083}
fi

exec $HIVE_HOME/bin/hive --skiphadoopversion --skiphbasecp --service $SERVICE_NAME