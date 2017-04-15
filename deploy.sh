#!/bin/bash
sudo docker build -t sr9000/sample-node .
sudo docker push sr9000/sample-node

ssh -i key sr9000@35.187.48.193 << EOF
docker pull sr9000/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi sr9000/sample-node:current || true
docker tag sr9000/sample-node:latest sr9000/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 sr9000/sample-node:current
EOF
