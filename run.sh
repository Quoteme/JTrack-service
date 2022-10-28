mkdir -p ./jutrack_data/studies

docker container run \
  -itd \
  --mount src="$(pwd)"/jutrack_data,target=/mnt/jutrack_data/studies,type=bind \
  --name my-running-app \
  -p 8888:80 my-apache
