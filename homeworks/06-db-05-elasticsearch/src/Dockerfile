FROM centos:7

WORKDIR /opt/elasticsearch

RUN yum -y update && yum install -y \
    wget \
    perl-Digest-SHA \
 && groupadd elasticsearch \
 && useradd elasticsearch -g elasticsearch -p elasticsearch \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512 \
 && shasum -a 512 -c elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512 \
 && tar -xzf elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && yum remove -y \
    wget \
    perl-Digest-SHA \
 && yum clean all \
 && mkdir /var/lib/data /var/lib/logs /var/lib/snapshots \
 && mv elasticsearch-8.6.1/* . \
 && chown -R elasticsearch:elasticsearch /opt/elasticsearch /var/lib/data /var/lib/logs /var/lib/snapshots \
 && rm -rv elasticsearch-8.6.1/ \
 && rm elasticsearch-8.6.1-linux-x86_64.tar.gz \
 && rm elasticsearch-8.6.1-linux-x86_64.tar.gz.sha512

USER elasticsearch
COPY ./elasticsearch.yml config/

ENTRYPOINT [ "bin/elasticsearch" ]

EXPOSE 9200 9300