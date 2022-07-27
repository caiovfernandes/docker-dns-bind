export IP_RANGE=172.20.0.0
export NETWORK_NAME=caio-net
export DNS_SERVER1_IP=172.20.0.2
export DNS_SERVER2_IP=172.20.0.3
export HOST1_IP=172.20.0.4
export HOST2_IP=172.20.0.5
export DNS_IMAGE_NAME=lab01_dns_server
export HOST_IMAGE_NAME=lab01_dns_host

all: all_dns_server all_hosts host1_shell

all_dns_server: create_network build_dns_servers run_dns_servers

all_hosts: build_hosts run_hosts

create_network:
	docker network create --subnet=${IP_RANGE}/16 ${NETWORK_NAME}

build_dns_servers:
	docker build -t ${DNS_IMAGE_NAME} dns-server/

run_dns_servers:
	docker run -d --rm --name=dns-server1 --net=${NETWORK_NAME} --ip=${DNS_SERVER1_IP} ${DNS_IMAGE_NAME}
	docker run -d --rm --name=dns-server2 --net=${NETWORK_NAME} --ip=${DNS_SERVER2_IP} ${DNS_IMAGE_NAME}
	docker exec -d dns-server1 /etc/init.d/bind9 start
	docker exec -d dns-server2 /etc/init.d/bind9 start

run_dns_server1:
	docker run -d --rm --name=dns-server1 --net=${NETWORK_NAME} --ip=${DNS_SERVER1_IP} ${DNS_IMAGE_NAME}
	docker exec -d dns-server1 /etc/init.d/bind9 start

run_dns_server2:
	docker run -d --rm --name=dns-server2 --net=${NETWORK_NAME} --ip=${DNS_SERVER2_IP} ${DNS_IMAGE_NAME}
	docker exec -d dns-server2 /etc/init.d/bind9 start

build_hosts:
	docker build -t ${HOST_IMAGE_NAME} host/

run_hosts:
	docker run -d --rm --name=host1 --net=${NETWORK_NAME} --ip=${HOST1_IP} --dns=${DNS_SERVER1_IP} --dns=${DNS_SERVER2_IP}  ${HOST_IMAGE_NAME}  /bin/bash -c "while :; do sleep 10; done"
	docker run -d --rm --name=host2 --net=${NETWORK_NAME} --ip=${HOST2_IP} --dns=${DNS_SERVER1_IP} --dns=${DNS_SERVER2_IP}  ${HOST_IMAGE_NAME}  /bin/bash -c "while :; do sleep 10; done"

clean:
	docker network rm ${NETWORK_NAME}
	docker rm ${DNS_IMAGE_NAME}
	docker rm ${HOST_IMAGE_NAME}

host1_shell:
	docker exec -it host1 /bin/bash

stop:
	docker stop dns-server1 dns-server2 host1 host2