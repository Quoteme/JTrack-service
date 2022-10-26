FROM ndegardin/apache-wsgi

# RUN apt-get update&& \
#     apt-get install\
#     apache2 libapache2-mod-wsgi-py3 && \
#     a2enmod wsgi && \
#     service apache2 restart
 
COPY ./corsano.de.conf /usr/local/apache2/conf/httpd.conf
COPY ./jtrack-dashboard2 /srv/remsys.ai/dashboard

COPY ./jutrackService.wsgi /var/www/remsys.ai/service/jutrackService.wsgi
COPY ./jutrack_fetch_resources.wsgi /var/www/remsys.ai/service/jutrack_fetch_resources.wsgi
COPY ./jutrack_dashboard_worker.py /var/www/remsys.ai/www/dashboard/jutrack_dashboard.wsgi
