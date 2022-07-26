 #! /bin/bash
 apt-get update -y
 curl -sfL https://get.k3s.io | sh -
 cat /var/lib/rancher/k3s/server/node-token