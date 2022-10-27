FROM almalinux:8.5

# Install Apache
RUN yum -y update && \
    yum -y install httpd httpd-tools && \
    yum -y install python3 && \
    yum -y install python3-mod_wsgi && \
    yum -y install python3-pip

RUN pip3 install --upgrade pip \
  && pip3 install fpdf \
  && pip3 install qrcode \
  && pip3 install pillow \
  && pip3 install pandas \
  && pip3 install dash \
  && pip3 install requests

RUN useradd www-data \
 && useradd lhappel \
 && groupadd -g 10000 dashboardgroup

RUN chown -R www-data:dashboardgroup /var/www/remsys.ai/www \
 && chmod -R u=rwx,g=rx,o-r /var/www/remsys.ai/www

# Update Apache Configuration
# RUN echo "" >> /etc/httpd/conf.d/example.conf \
#  && echo "WSGIScriptAlias / /var/www/html/wsgi.py" >> /etc/httpd/conf.d/example.conf \
#  && echo "WSGIScriptAlias /test /var/www/remsys.ai/www/test.wsgi" >> /etc/httpd/conf.d/example.conf \
#  && echo "<Directory /var/www/html>" >> /etc/httpd/conf.d/example.conf \
#  && echo "<Files wsgi.py>" >> /etc/httpd/conf.d/example.conf \
#  && echo "Require all granted" >> /etc/httpd/conf.d/example.conf \
#  && echo "</Files>" >> /etc/httpd/conf.d/example.conf \
#  && echo "</Directory>" >> /etc/httpd/conf.d/example.conf

COPY ./corsano.de.conf /etc/httpd/conf.d/corsano.de.conf

# COPY ./corsano.de.conf /etc/httpd/conf/httpd.conf
COPY ./JTrack-dashboard /srv/remsys.ai/dashboard

COPY ./test.wsgi /var/www/remsys.ai/www/test.wsgi
COPY ./test.wsgi /var/www/html/wsgi.py

COPY ./jutrack_fetch_resources.wsgi /var/www/remsys.ai/service/jutrack_fetch_resources.wsgi
COPY ./JTrack-dashboard /var/www/remsys.ai/www/dashboard
COPY ./jutrack_dashboard_worker.py /var/www/remsys.ai/www/dashboard/
COPY ./jutrackService.wsgi /var/www/remsys.ai/service/jutrackService.wsgi

COPY ./JTrack-dashboard/security/passwd.csv /

ENV PYTHONPATH=/var/www/remsys.ai/www/dashboard

EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
