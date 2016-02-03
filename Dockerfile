FROM centos:centos7
MAINTAINER Neogeo Technologies http://www.neogeo-online.net

ADD mongo.repo /etc/yum.repos.d/mongodb-org-3.2.repo
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-org; yum clean all
RUN mkdir -p /data/db
RUN mkdir -p /data/log
ADD ./mongod.conf /etc/mongod.conf

VOLUME ["/data/db"]
VOLUME ["/data/log"]

EXPOSE 27017

ENTRYPOINT ["/usr/bin/mongod", "--config", "/etc/mongod.conf"]