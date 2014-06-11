# gerrit
#
# VERSION               0.0.1

FROM tianon/centos:latest

MAINTAINER Matt Coffey

RUN yum install -y -q java-1.7.0-openjdk.x86_64
RUN yum install -y -q supervisor
RUN yum install -y -q vim

ENV GERRIT_HOME /home/gerrit/gerrit
ENV GERRIT_USER gerrit2
ENV GERRIT_WAR /home/gerrit/gerrit.war

RUN useradd -m ${GERRIT_USER}

ADD ./etc/supervisord.d/httpd.conf /etc/supervisord.d/httpd.conf
RUN mkdir -p /var/log/supervisor

ADD https://gerrit-releases.storage.googleapis.com/gerrit-2.8.5.war /tmp/gerrit.war
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p ${GERRIT_HOME}
RUN chown ${GERRIT_USER}:${GERRIT_USER} ${GERRIT_HOME}
RUN mv /tmp/gerrit.war ${GERRIT_WAR}
RUN chown -R ${GERRIT_USER}:${GERRIT_USER} ${GERRIT_HOME}

USER ${GERRIT_USER}
RUN java -jar ${GERRIT_WAR} init --batch -d ${GERRIT_HOME}

# clobber the gerrit config. set the URL to localhost:8080
ADD gerrit.config /home/gerrit/gerrit/etc/gerrit.config

# Setup supervisord
ADD ./etc/supervisord.d/gerrit.conf /etc/supervisord.d/gerrit.conf

USER root
EXPOSE 8080 29418

# Default CMD
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
