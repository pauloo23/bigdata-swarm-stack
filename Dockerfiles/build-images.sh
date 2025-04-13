#!/bin/bash

docker service create --name registry --publish published=5001,target=5000 registry:2

sleep 30
# Build and push images
cd hive-metastore
echo "Building hive-metastore image..."
docker build -t 127.0.0.1:5001/custom-hive-metastore:latest -f Dockerfile.hive-metastore . --no-cache
docker push 127.0.0.1:5001/custom-hive-metastore:latest

cd ..
cd airflow
echo "Building airflow image..."
docker build -t 127.0.0.1:5001/custom-airflow:latest -f Dockerfile.airflow . --no-cache
docker push 127.0.0.1:5001/custom-airflow:latest

cd ..
cd jupyterlab
echo "Building jupyterlab image..."
docker build -t 127.0.0.1:5001/custom-jupyter:latest -f Dockerfile.jupyter . --no-cache
docker push 127.0.0.1:5001/custom-jupyter:latest

cd ..
cd superset
echo "Building superset image..."
docker build -t 127.0.0.1:5001/custom-superset:latest -f Dockerfile.superset . --no-cache
docker push 127.0.0.1:5001/custom-superset:latest

echo "All images built and pushed successfully."