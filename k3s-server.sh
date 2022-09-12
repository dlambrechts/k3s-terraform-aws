#! /bin/bash
yum update -y

##### Install K3S #####

public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
curl -sfL https://get.k3s.io | sh -s - --tls-san $public_ip
mkdir /home/ec2-user/.kube
cp /etc/rancher/k3s/k3s.yaml /home/ec2-user/.kube/config
chown ec2-user /home/ec2-user/.kube
chmod -R 744 /home/ec2-user/.kube

echo "export KUBECONFIG=\"/home/ec2-user/.kube/config\"" >> /home/ec2-user/.bashrc

##### Install HELM from the binary #####

wget https://get.helm.sh/helm-v3.9.0-linux-amd64.tar.gz  # Descargar Binario
tar -zxvf helm-v3.9.0-linux-amd64.tar.gz                 # Descomprimir
mv linux-amd64/helm /usr/local/bin/helm                  # Mover


##### Install Hazelcast with HELM ######

#helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
#helm repo update
#helm install my-release -f values.yaml hazelcast/hazelcast-enterprise

## helm pull hazelcast/hazelcast-enterprise --untar