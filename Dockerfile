FROM almalinux:8.5

# Install Apache
RUN yum -y update && \
    yum -y install httpd httpd-tools && \
    yum -y install python3 && \
    yum -y install python3-mod_wsgi && \
    yum -y install python3-pip && \
    yum -y install zip && \
    yum -y install unzip
    # yum -y install datalad

RUN pip3 install --upgrade pip \
  && pip3 install fpdf \
  && pip3 install qrcode \
  && pip3 install pillow \
  && pip3 install pandas \
  && pip3 install dash \
  && pip3 install requests

RUN useradd www-data \
 && useradd lhappel \
 && useradd jtrack \
 && groupadd -g 10000 dashboardgroup

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

COPY ./jutrack_fetch_resources.wsgi /var/www/remsys.ai/service/jutrack_fetch_resources.wsgi
COPY ./JTrack-dashboard /var/www/remsys.ai/www/dashboard
COPY ./jutrack_dashboard_worker.py /var/www/remsys.ai/www/dashboard/
COPY ./jutrack_csv_cronjob.py /
COPY ./jutrackService.wsgi /var/www/remsys.ai/service/jutrackService.wsgi

COPY ./JTrack-dashboard/security/passwd.csv /

RUN chown -R www-data:dashboardgroup /var/www/remsys.ai/www \
 && chmod -R u=rwx,g=rx,o-r /var/www/remsys.ai/www \
 && chown -R www-data:dashboardgroup /mnt \
 && chmod -R a=rwx /mnt

ENV PYTHONPATH=/var/www/remsys.ai/www/dashboard
ENV SERVER_PROTOCOL=http://
ENV SERVER_URL=192.168.178.31:8888/
#ENV SERVER_URL=http://remsys.ai/

EXPOSE 80
RUN echo "#!/usr/bin/env bash" >> /start.sh && \
    echo "httpd -D FOREGROUND &" >> /start.sh && \
		echo "chmod -R a=rwx /mnt &" >> /start.sh && \
		echo "chmod -R a=rwx /mnt/jutrack_data/users/ &" >> /start.sh && \
		echo "echo 'changed permissions successfully' >> serverstart.log &" >> /start.sh && \
		echo "while true; do" >> /start.sh && \
		echo "  echo 'running' &" >> /start.sh && \
		echo "  python3 /jutrack_csv_cronjob.py &" >> /start.sh && \
		echo "  sleep 5" >> /start.sh && \
		echo "done" >> /start.sh && \
		chmod +x /start.sh
CMD ./start.sh
