FROM httpd:2.4

# RUN apt-get update && \
#     apt-get install --no-install-recommends -y \
#     libglobus-authz-dev
 
COPY ./corsano.de.conf /usr/local/apache2/conf/httpd.conf
COPY ./jtrack-dashboard2 /srv/remsys.ai/dashboard
