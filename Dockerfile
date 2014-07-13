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

# Odoo instalation
RUN apt-get install -y git
RUN sudo apt-get install -y python-pip
#RUN sudo pip install --upgrade virtualenv 

RUN mkdir -p /opt/odoo
RUN git clone -b 8.0 https://github.com/odoo/odoo.git /opt/odoo/server
RUN python /opt/odoo/server/setup.py install

EXPOSE 22 8069
#CMD ["/usr/bin/supervisord"]
CMD ["/opt/odoo/server/odoo.py -c /opt/odoo/odoo.conf"]
