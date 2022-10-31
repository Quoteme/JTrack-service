mkdir -p ./Studies
mkdir -p ./jutrack_data/studies
mkdir -p ./jutrack_data/archive
mkdir -p ./jutrack_data/users
chmod a=rwx ./jutrack_data

docker build -t my-apache . && \
docker container run \
  -itd \
  --mount src="$(pwd)"/jutrack_data,target=/mnt/jutrack_data,type=bind \
  --mount src="$(pwd)"/Studies,target=/var/www/remsys.ai/www/dashboard/Studies/,type=bind \
  --name my-running-app \
  -p 8888:80 my-apache
