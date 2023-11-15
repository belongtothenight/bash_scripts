#!/bin/bash

echo "Starting roboflow inference server..."
service docker restart
docker run -it --rm -p 9001:9001 roboflow/roboflow-inference-server-arm-cpu
