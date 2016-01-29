FROM centos:centos7
MAINTAINER Neogeo Technologies http://www.neogeo-online.net

ADD mongo.repo /etc/yum.repos.d/mongodb-org-3.2.repo
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install mongodb-org-shell; yum clean all
RUN yum -y install mongodb-org-tools; yum clean all