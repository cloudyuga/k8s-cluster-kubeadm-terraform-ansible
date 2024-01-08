#!/bin/bash
set -e

# Set hostname
echo "-------------Setting hostname-------------"
hostnamectl set-hostname $1

# Disable swap
echo "-------------Disabling swap-------------"
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Install kubectl, kubelet and kubeadm
echo "-------------Installing Kubectl, Kubelet and Kubeadm-------------"
apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "--------Installing Containerd with its prerequisite"
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sudo sysctl --system
sudo apt-get update && sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/  SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd


echo "-------------Printing Kubeadm version-------------"
kubeadm version

echo "-------------Pulling Kubeadm Images -------------"
kubeadm config images pull

echo "-------------Running kubeadm init-------------"
kubeadm init

echo "-------------Copying Kubeconfig-------------"
mkdir -p /root/.kube
cp -iv /etc/kubernetes/admin.conf /root/.kube/config
sudo chown $(id -u):$(id -g) /root/.kube/config

echo "-------------Exporting Kubeconfig-------------"
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "----------------- Installing Helm-------------"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "-------------Deploying Cilium-------------"
helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --version 1.14.5 --namespace kube-system

echo "------------Remove taints and tolerations----"
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "-------------Creating file with join command-------------"
echo `kubeadm token create --print-join-command` > ./join-command.sh

echo "-------------Creating Storage Class-------------"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml

echo "---------------------setting up Nginx Ingress Controller---------- "
kubectl apply -f deploy.yaml


