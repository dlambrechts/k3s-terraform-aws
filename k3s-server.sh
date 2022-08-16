#! /bin/bash
yum update -y

public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

curl -sfL https://get.k3s.io | sh -s - --tls-san $public_ip

mkdir /home/ec2-user/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ec2-user/.kube/config
chown ec2-user /home/ec2-user/.kube
chmod -R 744 /home/ec2-user/.kube

echo "export KUBECONFIG=\"/home/ec2-user/.kube/config\"" >> /home/ec2-user/.bashrc