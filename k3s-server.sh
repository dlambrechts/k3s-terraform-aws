 #! /bin/bash
 sudo apt-get update
 curl -sfL https://get.k3s.io | sh -
 cat /var/lib/rancher/k3s/server/node-token