#! /bin/bash
yum update -y
curl -sfL https://get.k3s.io | sh -
mkdir /home/ec2-user/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ec2-user/.kube/config
echo "export KUBECONFIG=\"/home/ec2-user/.kube/config\"" >> /home/ec2-user/.bashrc