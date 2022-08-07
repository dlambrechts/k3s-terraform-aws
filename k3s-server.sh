#! /bin/bash
yum update -y
curl -sfL https://get.k3s.io | sh -
mkdir .kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
echo "export KUBECONFIG=\"$HOME/.kube/config\"" >> .bashrc