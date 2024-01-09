# k8s-cluster-kubeadm-terraform-ansible
Create the K8s Cluster using Terraform and Ansible on AWS EC2 instances.

This repository contains Terraform and Ansible scripts to set up Kubeadm-based Kubernetes cluster on AWS EC2 instances. With this, one can form a single master node cluster or a single master-multiple worker node cluster to dive deep into Kubernetes concepts and prepare for Kubernetes-based certifications.

## Prerequisite and Installation
### Setup AWS Account and Install AWS CLI Tool
- Create AWS account from [here](https://aws.amazon.com/).
- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) according to your system configuration.
```
# For Ubuntu-based system
sudo apt install python3-pip -y
sudo pip install awscli
```
- Run the following command to connect to your AWS account from your Terminal.
```
aws configure
```


