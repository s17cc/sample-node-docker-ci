#!/bin/bash
docker build -t zytfo/sample-node .
docker push zytfo/sample-node

ssh deploy@35.187.30.81 << EOF
docker pull zytfo/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi zytfo/sample-node:current || true
docker tag zytfo/sample-node:latest zytfo/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 zytfo/sample-node:current
EOF
