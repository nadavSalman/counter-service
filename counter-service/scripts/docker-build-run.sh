#!/bin/bash

docker build -t counter-service:1.0.0 .
docker run --rm -it -p 5000:5000 counter-service:1.0.0
