# This is a comment
FROM ubuntu:14.04
MAINTAINER Damian Soriano <ds@ingadhoc.com>
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --allow-unauthenticated -y openssh-server supervisor

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

RUN useradd -p odoo odoo
RUN echo 'root:odoo' | chpasswd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt-get install -y git
RUN mkdir -p /opt/odoo
RUN sudo apt-get install -y python-pip

RUN git clone -b saas-5 https://github.com/odoo/odoo.git /opt/odoo/

EXPOSE 22 8069
CMD ["/usr/bin/supervisord"]
