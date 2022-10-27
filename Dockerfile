FROM seth0r/apache-wsgi
RUN apt-get update \
  && apt-get install -y \
    apache2 \
    apache2-dev \
    apache2-utils \
    ntpdate \
  && apt autoremove \
  && apt clean
  # && a2enconf mod-wsgi
# RUN apt-get update 
# RUN apt-get install apache2 
# RUN apt install apache2-utils
# RUN apt install libexpat1 ssl-cert python
# RUN apt install libapache2-mod-wsgi
# RUN systemctl restart apache2
# RUN apt clean 
# RUN apt clean 

RUN groupadd -g 1000 dashboardgroup

COPY ./corsano.de.conf /etc/apache2/sites-enabled/corsano.de.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY ./jtrack-dashboard2 /srv/remsys.ai/dashboard

COPY ./jutrackService.wsgi /var/www/remsys.ai/service/jutrackService.wsgi
COPY ./jutrack_fetch_resources.wsgi /var/www/remsys.ai/service/jutrack_fetch_resources.wsgi
COPY ./JTrack-dashboard /var/www/remsys.ai/www/dashboard
# COPY ./jutrack_dashboard_worker.py /var/www/remsys.ai/www/dashboard/jutrack_dashboard.wsgi

COPY ./test.wsgi /var/www/remsys.ai/www/test.wsgi

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

# RUN apt-get update&& \
#     apt-get install\
#     apache2 libapache2-mod-wsgi-py3 && \
#     a2enmod wsgi && \
#     service apache2 restart
