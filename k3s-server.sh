 #! /bin/bash
 yum update -y
 curl -sfL https://get.k3s.io | sh -
 cp /etc/rancher/k3s/k3s.yaml ~/.kube/config