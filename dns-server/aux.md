echo docker run -d --rm --name=dns-server1 --net=${NETWORK_NAME} --ip=${DNS_SERVER1_IP} ${DNS_IMAGE_NAME}

docker run -d --rm --name=dns-server2 --net=${NETWORK_NAME} --ip=${DNS_SERVER2_IP} ${DNS_IMAGE_NAME}
echo docker run -d --rm --name=dns-server2 --net=${NETWORK_NAME} --ip=${DNS_SERVER2_IP} ${DNS_IMAGE_NAME}


docker run -d --rm --name=host1 --net=caio-net --ip=172.20.0.3 --dns=172.20.0.2 172.20.0.3  ubuntu:bionic /bin/bash -c "while :; do sleep 10; done"