FROM ubuntu 
RUN apt-get update \
  && apt-get install -y \
    apache2 \
    apache2-dev \
    apache2-utils \
    ntpdate \
    python3 python3-pip\
  && pip install mod_wsgi\
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


# COPY ./corsano.de.conf /usr/local/apache2/conf/httpd.conf
# COPY ./jtrack-dashboard2 /srv/remsys.ai/dashboard

# COPY ./jutrackService.wsgi /var/www/remsys.ai/service/jutrackService.wsgi
# COPY ./jutrack_fetch_resources.wsgi /var/www/remsys.ai/service/jutrack_fetch_resources.wsgi
# COPY ./jutrack_dashboard_worker.py /var/www/remsys.ai/www/dashboard/jutrack_dashboard.wsgi

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]

# RUN apt-get update&& \
#     apt-get install\
#     apache2 libapache2-mod-wsgi-py3 && \
#     a2enmod wsgi && \
#     service apache2 restart
