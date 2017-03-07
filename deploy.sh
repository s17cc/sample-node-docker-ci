#!/bin/bash
#docker build -t kostyaurysov/sample-node .
#docker push kostyaurysov/sample-node


ssh root@46.101.228.243 << EOF
docker pull x3medima17/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi x3medima17/sample-node:current || true
docker tag x3medima17/sample-node:latest x3medima17/sample-node:current
docker run -d --net cc --restart always --name web -p 80:80 x3medima17/sample-node:current
EOF
