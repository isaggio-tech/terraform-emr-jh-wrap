#!/usr/bin/env bash

# Commenting SSL Settings
sed 's/c.JupyterHub.ssl/#c.JupyterHub.ssl/g' /etc/jupyter/conf/jupyterhub_config.py > /etc/jupyter/conf/jupyterhub_config.py.modified
mv /etc/jupyter/conf/jupyterhub_config.py.modified /etc/jupyter/conf/jupyterhub_config.py

# Restart Jupyterhub
docker stop jupyterhub
docker start jupyterhub

# GET IPADDRESS
export DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' jupyterhub)
export JH_PORT=9988

# Expose Http Port
iptables -t nat -A  DOCKER -p tcp --dport ${JH_PORT} -j DNAT --to-destination ${DOCKER_IP}:${JH_PORT}
iptables -t nat -A POSTROUTING -j MASQUERADE -p tcp --source ${DOCKER_IP} --destination ${DOCKER_IP} --dport ${JH_PORT}
iptables -A DOCKER -j ACCEPT -p tcp --destination ${DOCKER_IP} --dport ${JH_PORT}
