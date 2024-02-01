# Phishing2024

## Table of contents

1. [Deploy AWS Instances](#deploy-aws-instances)

## Infrastructure Setup

### Establish Email

- Use an email provider of your choice for the creation of this infrastructure.

### Establish Domain

Establish a Domain used for the engagement. The following links can assist in identifying potential domains.

**DNS Finder Tools**

- https://github.com/urbanadventurer/urlcrazy
- https://github.com/elceef/dnstwist

**DNS Finder Websites**

- https://dnstwist.it/
- https://www.expireddomains.net/

**DNS Reputation Websites**

- https://urlfiltering.paloaltonetworks.com/query/
- https://talosintelligence.com/reputation_center/

### Domain Setup

## Deploy AWS Instances

To deploy AWS instances you can use the terraform template provided in [`aws_instances.tf`](/aws_instances.tf). This template creates one AWS EC2 instance with the following details:

- `ap-southeast-2`
- Ubuntu Server 22.04 - `ami-04f5097681773b989`
  - `t2.micro` Instance type

To deploy the terraform template you require:

- Terraform CLI (1.2.0+) installed
- The AWS CLI installed

See here for all details/video instructions - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

The template requires that you create an `SSH` key locally and insert the generated public key + key_name into the template. This key will be used for SSH connections to the instance.

After deploying, the instance should be available in AWS.

#### Ensure that your IP is permitted to access the EC2 Instance in the newly created security group if you did not insert your IP in the Terraform template.

#### Create a Key-Pair for the EC2 Instance

-- Below is inaccurate --

After logging in - Either through `SSH` or `EC2 Instance Connect` you can initialise the virtual machine using the script ``

run script

- do `go build`

if there are sudo issues - https://askubuntu.com/questions/59458/error-message-sudo-unable-to-resolve-host-none

https://help.evilginx.com/docs/getting-started/building - EvilGinx setup

SSH Tunneling
ssh -L 8080:localhost:3333 ubuntu@pub001.host

key is in statefile not that effective

---

# 1/02

- Install AWS CLI and login

- Install terraform
  - add/modify the terraform template for your own personal SSH key
  - ssh-keygen -m PEM -f `file-name`
  - add the pub key to terraform template
  - `terraform validate` -> `terraform apply`
