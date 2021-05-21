#!/bin/bash

set -x

core_num=$CORE_NUM
job_manager_host=127.0.0.1
job_manager_rest_port=8081
job_manager_rpc_port=6123
secure_password=`openssl rsautl -inkey /opt/password/key.txt -decrypt </opt/password/output.bin`
flink_home=$FLINK_HOME
flink_version=$FLINK_VERSION

echo "### Launching Flink Jobmanager ###"

java \
    -Xms5g \
    -Xmx10g \
    -XX:ActiveProcessorCount=${core_num} \
    -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2" \
    -Dorg.apache.flink.shaded.netty4.io.netty.tryReflectionSetAccessible=true \
    -Dorg.apache.flink.shaded.netty4.io.netty.eventLoopThreads=${core_num} \
    -Dcom.intel.analytics.zoo.shaded.io.netty.tryReflectionSetAccessible=true \
    -Dlog.file=${flink_home}/log/flink-sgx-standalonesession-1-sgx-ICX-LCC.log \
    -Dlog4j.configuration=file:${flink_home}/conf/log4j.properties \
    -Dlogback.configurationFile=file:${flink_home}/conf/logback.xml \
    -classpath ${flink_home}/lib/flink-table_2.11-${flink_version}.jar:${flink_home}/lib/flink-table-blink_2.11-${flink_version}.jar:${flink_home}/lib/log4j-1.2.17.jar:${flink_home}/lib/slf4j-log4j12-1.7.15.jar:${flink_home}/lib/flink-dist_2.11-${flink_version}.jar::: org.apache.flink.runtime.entrypoint.StandaloneSessionClusterEntrypoint \
    --configDir ${flink_home}/conf \
    -D rest.bind-address=${job_manager_host} \
    -D rest.bind-port=${job_manager_rest_port} \
    -D jobmanager.rpc.address=${job_manager_host} \
    -D jobmanager.rpc.port=${job_manager_rpc_port} \
    -D jobmanager.heap.size=5g \
    -D security.ssl.internal.enabled=true \
    -D security.ssl.internal.keystore=/opt/keys/keystore.pkcs12 \
    -D security.ssl.internal.truststore=/opt/keys/keystore.pkcs12 \
    -D security.ssl.internal.keystore-password=${secure_password} \
    -D security.ssl.internal.truststore-password=${secure_password} \
    -D security.ssl.internal.key-password=${secure_password} \
    --executionMode cluster | tee ./flink-jobmanager-sgx.log

