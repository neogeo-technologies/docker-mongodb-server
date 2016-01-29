# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# adapted by Guillaume Sueur eand Benjamin Chartier
#	http://www.neogeo-online.net
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
ADD mongo.repo /etc/yum.repos.d/mongodb-org-3.2.repo
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-org; yum clean all
RUN mkdir -p /data/db
RUN mkdir -p /data/log
# RUN mkdir -p /data/scripts
ADD ./mongod.conf /etc/mongod.conf
# ADD ./run.sh /data/scripts/run.sh
# RUN ["chmod", "+x", "/data/scripts/run.sh"]

VOLUME ["/data/db"]
VOLUME ["/data/log"]

EXPOSE 27017

ENTRYPOINT ["/usr/bin/mongod", "--config", "/etc/mongod.conf"]