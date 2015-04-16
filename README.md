# elasticsearch-marathon

A Marathon-enabled Docker instance containing ElasticSearch.

## Sample Configuration

As decribed in https://mesosphere.github.io/marathon/docs/rest-api.html#post-/v2/apps we need to fire a POST request to the `/v2/apps` endpoint to create a new application.

So, if your Marathon instance is running at http://127.0.0.1:8080 your request could look like the one below. Please set the correct `parameters` values for your individual configuration.

```
curl -XPOST 'http://127.0.0.1:8080/v2/apps' -d '{
    "id": "es-cluster",
    "env": {
	"MARATHON_URL": "http://127.0.0.1:8080",
	"APP_ID": "es-cluster",
	"ELASTICSEARCH_CLUSTER_NAME": "MYCLUSTER"
    },
    "container": {
        "docker": {
            "image": "tobilg/elasticsearch-marathon",
            "network": "BRIDGE",
            "portMappings": [
                { "containerPort": 9200 },
                { "containerPort": 9300 }
            ]
        },
        "type": "DOCKER"
    },
    "cpus": 0.5,
    "mem": 2048,
    "instances": 2
}'
```

## How it works

Upon the container startup, the shell script `elasticsearch-marathon-bootstrap.sh` is executed, which first calls another Node.js script (`elasticsearches.js`)  to query the Marathon REST API to get the list of tasks for the given app id. 

The resulting node list is then fed into the ElasticSearch startup script parameter `discovery.zen.ping.unicast.hosts`, thus enabling the ElasticSearch unicast discovery to build a cluster. 

This is done dynamically at instance start, meaning that if you scale the application via the Marathon frontend, the further instances are automatically added to the given cluster (which name is set via the `ELASTICSEARCH_CLUSTER_NAME` environment variable in the config JSON, see above).

