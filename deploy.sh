#!/bin/bash
docker push kkhanda/sample-node

ssh deploy@35.195.193.222 << EOF
docker pull kkhanda/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi kkhanda/sample-node:current || true
docker tag kkhanda/sample-node:latest kkhanda/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 kkhanda/sample-node:current
EOF
