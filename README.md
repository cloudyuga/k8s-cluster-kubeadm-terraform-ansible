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
- Verify the installation
```
   aws --version
```
- Generate AWS Access Key and Secret Key, which will be used in the next step. Follow [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user_manage_add-key.html) to learn how to generate them.
- Run the following command to connect to your AWS account from your terminal and pass the access and secret keys, respectively.
```
aws configure
```

### Install Ansible
- Run the following commands to install Ansible for ubuntu-based system.
```
sudo apt update
sudo apt install software-properties-common -y

sudo apt-add-repository ppa:ansible/ansible
sudo apt update && sudo apt install ansible -y
```
- Verify the Ansible installation
```
ansible --version
```






