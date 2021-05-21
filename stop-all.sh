#!/bin/bash

# Stop cluster serving
${FLINK_HOME}/bin/flink list | grep RUNNING | awk '{print $4}' | xargs ${FLINK_HOME}/bin/flink cancel
ps -ef | grep http.jar | awk '{print $2}' | xargs kill -9

# Stop Flink
${FLINK_HOME}/bin/jobmanager stop

# Stop Redis
${REDIS_HOME}/src/redis-cli shutdown
