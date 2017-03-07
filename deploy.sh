#!/bin/bash
docker build -t mboronin/sample-node .
docker push mboronin/sample-node

ssh deploy@35.187.91.220 << EOF
docker pull mboronin/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi mboronin/sample-node:current || true
docker tag mboronin/sample-node:latest mboronin/sample-node:current
docker run -d --net app --restart always --name web -p 80:80 mboronin/sample-node:current
EOF
