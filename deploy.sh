#!/bin/bash
#docker build -t asverasver/sample-node .
#docker push asverasver/sample-node

ssh deploy@104.198.161.225
docker pull asverasver/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi asverasver/sample-node:current || true
docker tag asverasver/sample-node:latest asverasver/sample-node:current
docker run -d --net lab6net --restart always --name web -p 80:80 asverasver/sample-node:current
