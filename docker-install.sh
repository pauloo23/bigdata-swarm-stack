curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo '{"insecure-registries":["127.0.0.1:5001"]}' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker