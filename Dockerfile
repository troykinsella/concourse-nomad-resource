FROM ubuntu:latest
LABEL MAINTAINER="Troy Kinsella <troy.kinsella@gmail.com>"

COPY assets/* /opt/resource/

RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update -y; \
    apt-get install -y \
      apt-transport-https \
      curl \
      gnupg \
      jq \
      lsb-release; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -; \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list; \
    apt-get update -y; \
    apt-get install -y nomad; \
    apt-get remove -y lsb-release; \
    apt-get clean all; \
    rm -rf /var/lib/apt/lists/*;
