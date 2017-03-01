#!/bin/bash
# docker build -t kostyaurysov/sample-node .
docker push fred14/sample-node

ssh key kouakam@35.187.12.218 << EOF
docker pull fred14/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi fred14/sample-node:current || true
docker tag fred14/sample-node:latest fred14/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 fred14/sample-node:current
EOF
