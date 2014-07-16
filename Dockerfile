FROM ubuntu:14.04
MAINTAINER Damian Soriano <ds@ingadhoc.com>

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
#RUN apt-get install --allow-unauthenticated -y openssh-server supervisor

#RUN mkdir -p /var/run/sshd
#RUN mkdir -p /var/log/supervisor

RUN useradd -m -p odoo odoo
RUN echo 'root:odoo' | chpasswd

#ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Odoo instalation
#RUN sudo pip install --upgrade virtualenv 

RUN apt-get update && apt-get install -y python-pip python-dev build-essential libpq-dev poppler-utils antiword libldap2-dev libsasl2-dev libssl-dev git python-dateutil python-feedparser python-gdata python-ldap python-lxml python-mako python-openid python-psycopg2 python-pychart python-pydot python-pyparsing python-reportlab python-tz python-vatnumber python-vobject python-webdav python-xlwt python-yaml python-zsi python-docutils python-unittest2 python-mock python-jinja2 libevent-dev libxslt1-dev libfreetype6-dev libjpeg8-dev python-werkzeug wkhtmltopdf libjpeg-dev nginx

RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y python-pip

RUN mkdir -p /opt/odoo
RUN git clone -b 8.0 https://github.com/odoo/odoo.git /opt/odoo/server

RUN (cd /opt/odoo/server/ ; python setup.py install)

ADD odoo.conf /opt/odoo/server/odoo.conf

RUN chown -R odoo.odoo server/

#RUN cd /opt/odoo/server/

#EXPOSE 22 8069
#CMD ["/usr/bin/supervisord"]
CMD ["sudo -u odoo /opt/odoo/server/odoo.py -c /opt/odoo/server/odoo.conf"]
#CMD ["/bin/bash"]
