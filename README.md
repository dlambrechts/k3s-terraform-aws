# Run a K3s Cluster on EC2

- A kubeconfig file will be written to /etc/rancher/k3s/k3s.yaml
- The value to use for K3S_TOKEN is stored at /var/lib/rancher/k3s/server/node-token

Add worker node:

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -
```
