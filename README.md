# Evilginx3 + GoPhish
Modified repository of https://github.com/fin3ss3g0d/evilgophish focused on AWS Infrastructure with Cloudflare as a proxy.

## Setup Files

### aws_instances.tf - Terraform
`aws_instances.tf` is a Terraform template that creates an EC2 instance. Default values include:
- Region for `ap-southeast-2`.
- Free Ubuntu AMI named `EvilGinx3-GoPhish-Phishing`.
- Default subnet and vpc for `ap-southeast-2`.
- Security group `allow_ssh` which allows connections from:
  - EC2 Instance Connect - `ap-southeast-2` IP Range.
  - Cloudflare IPs.
- AWS Key Pair Generation which requires a public key to be inserted during initialisation.

### setup.sh
Provides setup and installation for Evilginx3, Apache, and GoPhish. To run this script, your domain and DNS hosting must be operational.

## Domain Setup
### Deploy AWS Instances

To deploy the terraform template it requires:

- Terraform CLI (1.2.0+)
- AWS CLI 

See here for all details/video instructions to deploy `aws_instances.tf` - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

The template requires that you create an `SSH` key locally and insert the generated public key + key_name into the template. This key will be used for SSH connections to this instance.

```Ensure that your IP is permitted to access the EC2 Instance in the newly created security group in AWS.```

[Amazon Documentation - Import public key](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws_) - ``` ssh-keygen -m PEM -f `file-name` ```

After creating your Key-Pair and modifying the terraform file run `terraform validate` to validate the modified file and `terraform apply` to apply changes. After deployment newly created instances can be found in AWS.

To destroy your infrastructure run `terraform destroy`.

## Instance Setup

### Network Manager
- Modify Network Manager as by default it uses a proxy for DNS.
  - Can identify this with netstat -nltp | grep 53.
  - We need EvilGinx to listen on port 53.
  - `sudo systemctl stop systemd-resolved.service` will fix this.
- To fix DNS resolution
  - `nano resolv.conf`
  - Add Cloudflar DNS Resolvers - https://developers.cloudflare.com/1.1.1.1/ip-addresses/
    - `nameserver 1.1.1.1`
    - `nameserver 1.0.0.1`
- To fix it permanently <TO CHECK>
    - `nano /etc/NetworkManager/NetworkManager.conf`
    - add `dns=default` under `[main]` 


### Setup

Before setup ensure:
- You have an email and domain established.
- The domain is setup in Cloudflare.
- You know the phishlet you're running and subdomains are setup correctly in Cloudflare.

Download the Infrastructure folder onto your Instance and run `setup.sh` with elevated permissions. This script will:
  - Use letsencrypt for  certificate generation for apache
  - Install all dependecies with apt
  - Setup EvilGinx3
  - Setup GoPhish


## To add during E2E testing
- Confirm DNS Resolution