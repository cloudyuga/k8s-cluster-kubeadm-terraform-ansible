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
- Run the following commands to install Ansible for Ubuntu-based system.
```
sudo apt update
sudo apt install software-properties-common -y

sudo apt-add-repository ppa:ansible/ansible
sudo apt update && sudo apt install ansible -y
```
- Verify the Ansible installation.
```
ansible --version
```
### Install Terraform
- Install Terraform on Ubuntu-based system.
```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install terraform -y
```
- Verify the Terraform installation.
```
terraform version
```

## Clone the GitHub Repository and Spin up EC2 Instances
- Clone this GitHub repository; if you want to clone a specific branch, then use `-b <branch-name>` with below command
With this , we will spin up Kubeadm Kubernetes cluster with local-path storage class and nginx ingress controller.
```
git clone https://github.com/cloudyuga/k8s-cluster-kubeadm-terraform-ansible.git -b single-master-sc-ingress
cd k8s-cluster-kubeadm-terraform-ansible
```
- Generate the SSH keypair and store them in k8s filename to login into the AWS EC2 instances
```
ssh-keygen -f k8s
```
- By default the cluster will only have a single master node, but if you want to add worker nodes, then change the worker node count in the `variables.tf` file as shown below
```
variable "worker_instance_count" {
  type    = number
  default = 0   # increase this , if worker node in cluster needs to be created
  }
```

- As the cluster is going to be Kubeadm-based, refer to `master.sh` and file to see the different things needed to create a Kubeadm-based cluster.

- Finally, run the following command to install terraform AWS provider.
```
terraform init
```
- Check how terraform is going to create the EC2 instances and setup cluster inside the machine.
```
terraform plan
```
- Now, create the EC2 instances with Terraform and cluster as well
```
terraform apply -auto-approve
```

Wait for sometime as it is going to create EC2 instances , VPC , security groups and other required things along with cluster setup.
- Once the process is finished , verfiy EC2 instance creation in your AWS console under the `us-east-1` region.
- Do SSH inside the master EC2 instance node with the keypair generated above.
```
ssh -i k8s ubuntu@<master-node-public-ip-address>
```

## Accessing the Kubeadm Kubernetes cluster
- Once inside the master node, switch from **ubuntu** user to **root** user.
```
sudo su
```
- Check the Kubernetes cluster nodes **Ready** status.
```
kubectl get nodes
```
![k8s-terraform-node](https://github.com/oshi36/k8s-cluster-kubeadm-terraform-ansible/assets/47573417/9d74ed3e-ce5f-4630-b479-c61b753fbe80)

- Verify the Storage class and Nginx Ingress controller pods are running along with other pods
```
kubectl get pods -A
```
![ingress-nginx-k8s-pods](https://github.com/oshi36/k8s-cluster-kubeadm-terraform-ansible/assets/47573417/fba12c3a-7323-4fda-81c6-d01bb7acb347)
![ingress-nginx-terraform-cluster](https://github.com/oshi36/k8s-cluster-kubeadm-terraform-ansible/assets/47573417/49eec303-816e-43b5-9661-5086292fdc20)


## Destroy the setup
- Come out of the AWS EC2 instance and run the following command on your host system.
```
terraform destroy
```
This will remove the AWS EC2 instances , VPC, security groups that have been created by terraform.Verify the removal of them in your AWS console.This is important because if not removed , AWS will charge based on the usage of the AWS services.

NOTE: If you want to have storage class or Nginx Ingress controller in the Kubernetes cluster then follow the below steps:
- List the branches and switch to the desired branch.
```
git branch -a
git checkout <branch-name>
```
- Again run the `terraform apply` command.
```
terraform apply -auto-approve
```
This will update and install the requirements.



