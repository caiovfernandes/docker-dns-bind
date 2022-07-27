# Project Requirements
- docker


# Quick Test
1. Run all with make:
```shell
make
```

2. Inside of the host1 container (already in after `make`):
```shell
ping host1.caio-foundation.com
# OR
ping host2.caio-foundation.com
```

## Environments variables

```bash
export IP_RANGE=172.20.0.0
export NETWORK_NAME=caio-net
export DNS_SERVER1_IP=172.20.0.2
export DNS_SERVER2_IP=172.20.0.3
export HOST1_IP=172.20.0.4
export HOST2_IP=172.20.0.5
export DNS_IMAGE_NAME=lab01_dns_server
export HOST_IMAGE_NAME=lab01_dns_host
```

## Docker network

1. Creating a Docker network:
```bash
docker network create --subnet=${IP_RANGE}/16 ${NETWORK_NAME}
```


# Executing DNS_SERVERS

```bash
cd dns-server/
```

1. Building docker image:
```bash
docker build -t ${DNS_IMAGE_NAME} .
```

2. Running container
```bash
docker run -d --rm --name=dns-server --net=${NETWORK_NAME} --ip=${DNS_SERVER_IP} ${DNS_IMAGE_NAME}
```

3. Starting bind9 service
```bash
docker exec -d dns-server /etc/init.d/bind9 start
```

# Running hosts

```bash
cd host/
```


1. Building docker image
```bash
docker build -t ${HOST_IMAGE_NAME} .
```

2. Running host 1
```bash
docker run -d --rm --name=host1 --net=${NETWORK_NAME} --ip=${HOST1_IP} --dns=${DNS_SERVER_IP} ${HOST_IMAGE_NAME} /bin/bash -c "while :; do sleep 10; done"
```

3. Running host 2
```bash
docker run -d --rm --name=host1 --net=${NETWORK_NAME} --ip=${HOST2_IP} --dns=${DNS_SERVER_IP} ${HOST_IMAGE_NAME} /bin/bash -c "while :; do sleep 10; done"
```


## Testing Connections

- Inside the container, it is possible to verify that the host2 is reachable from the host1, using the DNS

1. Accessing host1 container:
```bash
docker exec -it host1 bash
```

2. Inside of host1, getting host2 IP throw the DNS_SERVER:
```bash
ping host2.caio-foundation.com
```