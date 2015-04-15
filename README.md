# docker-elasticsearch-marathon

A Marathon-enable Docker instance containing ElasticSearch.

## Sample Configuration

As decribed in https://mesosphere.github.io/marathon/docs/rest-api.html#post-/v2/apps we need to fire a POST request to the `/v2/apps` endpoint to create a new application.

So, if your Marathon instance is running at http://127.0.0.1:8080 your request could look like the one below. Please set the correct `parameters` values for your individual configuration.

```
curl -XPOST 'http://127.0.0.1:8080/v2/apps' -d '{
    "id": "es-cluster", 
    "container": {
        "docker": {
            "image": "tobilg/elasticsearch-marathon",
            "network": "BRIDGE",
            "portMappings": [
                { "containerPort": 9200 },
                { "containerPort": 9300 }
            ],
            "parameters": [
                { "key": "MARATHON_URL", "value": "http://127.0.0.1:8080" },
                { "key": "APP_ID", "value": "es-cluster" },
                { "key": "ELASTICSEARCH_CLUSTER_NAME", "value": "MYCLUSTER" }
            ]
        },
        "type": "DOCKER"
    },
    "cpus": 0.5,
    "mem": 2048,
    "instances": 2
}'
```
