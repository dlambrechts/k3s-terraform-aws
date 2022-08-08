#! /bin/bash
yum update -y

curl -sfL https://get.k3s.io | sh -

mkdir /home/ec2-user/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ec2-user/.kube/config
chown ec2-user /home/ec2-user/.kube
chmod 644 /home/ec2-user/.kube

echo "export KUBECONFIG=\"/home/ec2-user/.kube/config\"" >> /home/ec2-user/.bashrc