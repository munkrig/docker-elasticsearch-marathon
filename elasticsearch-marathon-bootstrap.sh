#!/bin/bash

hosts=$(/usr/local/bin/elasticsearches.js $MARATHON_URL $APP_ID)
node_name="${APP_ID}-${PORT0}"
cluster_name="${ELASTICSEARCH_CLUSTER_NAME}"

eval "/elasticsearch/bin/elasticsearch --node.name=${node_name} --cluster.name=${cluster_name} --network.publish_host=${HOST} --discovery.zen.ping.multicast.enabled=false --discovery.zen.ping.unicast.hosts=${hosts} --discovery.zen.ping_timeout=30s --discovery.zen.join_timeout=300s --discovery.zen.publish_timeout=300s --http.port=9200 --transport.tcp.port=9300 --transport.publish_port=${PORT1} ${ES_OPTIONS}"
