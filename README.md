Odoo 8.0 Docker
===========

This document explain how to lunch Odoo in a conteiner linked to another Postgresql container.

First of all we will need a container running Postgresql:

	sudo docker run --name odoo-db -e LC_ALL=C.UTF-8 postgres

Then is necesary to see the postgres IP to connect to it and create the user odoo. To get the IP of the postgres container we can run the following command:

	sudo docker inspect odoo-db | grep IPAddress
        "IPAddress": "172.17.0.42",

Once we get the IP we can connect to the database:
	
	psql -h 172.17.0.42 -p 5432 -U postgres

and create the odoo user as follows:

	CREATE USER odoo WITH PASSWORD 'odoo';
	ALTER USER odoo WITH SUPERUSER;

With all this configuration we are ready to run odoo connected to the previously configured container with the following command:

	sudo docker run -t -i -p 8069:8069 --link odoo-db:odoo-db damiansoriano/odoo-docker sudo -H -u odoo /opt/odoo/server/odoo.py -c /opt/odoo/server/odoo.conf
