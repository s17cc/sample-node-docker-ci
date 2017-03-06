#!/bin/bash
docker build -t fred14/sample-node .
docker push fred14/sample-node
ssh kouakam@104.155.64.132 << EOF
docker pull fred14/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi fred14/sample-node:current || true
docker tag fred14/sample-node:latest fred14/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 fred14/sample-node:current
EOF
