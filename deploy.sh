#!/bin/bash
docker build -t zytfo/cont_image .
docker push zytfo/cont_image

ssh innostepanova@35.198.81.139 << EOF
docker pull zytfo/cont_image:latest
docker stop web || true
docker rm web || true
docker rmi zytfo/cont_image:current || true
docker tag zytfo/cont_image:latest zytfo/cont_image:current
docker run -d --restart always --name web -p 80:80 zytfo/cont_image:current
EOF
