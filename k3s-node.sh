#! /bin/bash
yum update -y


# /var/lib/rancher/k3s/server/node-token
# curl -sfL https://get.k3s.io | K3S_URL=https://10.0.0.182:6443 K3S_TOKEN=K10268d324f8fc91042ec6f39a3858bde9645690a3696140682892314f12c388f57::server:b996fd70db2d08db6ef9abf037c8f9c9 sh -

# uninstall worker node:
# /usr/local/bin/k3s-agent-uninstall.sh

# uninstall server node:
# /usr/local/bin/k3s-uninstall.sh