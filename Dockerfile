# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jonathan Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ADD nzbget-19.1-1.el7.x86_64.rpm /tmp/nzbget-19.1-1.el7.x86_64.rpm
RUN curl https://negativo17.org/repos/epel-rar.repo -o /etc/yum.repos.d/epel-rar.repo
RUN curl https://negativo17.org/repos/epel-multimedia.repo -o /etc/yum.repos.d/epel-multimedia.repo
RUN yum install -y /tmp/nzbget-19.1-1.el7.x86_64.rpm
RUN yum install -y supervisor par2cmdline unrar p7zip p7zip-plugins unzip ffmpeg logrotate
RUN rm /tmp/nzbget-*
RUN yum update -y
RUN yum clean all

ADD supervisord.conf /etc/supervisord.conf
ADD nzbget.ini /etc/supervisord.d/nzbget.ini
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config
VOLUME /downloads

EXPOSE 6789 9006
ENTRYPOINT ["/usr/sbin/start.sh"]
