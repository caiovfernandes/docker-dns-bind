FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install -y \
  dnsutils \
  iputils-ping \
  vim

CMD ["/bin/bash", "-c", "while :; do sleep 10; done"]