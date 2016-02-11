FROM centos:centos7
MAINTAINER Neogeo Technologies http://www.neogeo-online.net

ADD mongo.repo /etc/yum.repos.d/mongodb-org-3.2.repo
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install \
	mongodb-org \
	pwgen \
	; yum clean all

ENV DATADIR /data
ENV SUPERUSER neogeo
# ENV SUPERPASS neogeo

ADD ./mongod.conf /etc/mongod.conf

# Add scripts
ADD scripts /scripts
RUN chmod +x /scripts/*.sh

CMD ["/scripts/run.sh"]

VOLUME ["$DATADIR/db", "$DATADIR/log"]
EXPOSE 27017