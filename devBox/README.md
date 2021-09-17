<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

# Confluent replication environment
  - [Description](#description)
  - [Prerequisites](#prerequisites)
  - [How to run](#how-to-run)
  - [Useful output from terraform](#useful-output-from-terraform)
  - [Variables](#variables)
  - [## Working AMI and EC2 type instace on a per region basis.](#-working-ami-and-ec2-type-instace-on-a-per-region-basis)
  - [Architecture](#architecture)
  - [Common issue](#common-issue)
    - [Duplicate EC2 key pair](#duplicate-ec2-key-pair)
      - [Resolution](#resolution)
    - [AWS Key/Secret are misconfigured](#aws-keysecret-are-misconfigured)
      - [Resolution](#resolution-1)
    - [Too many authentication failures](#too-many-authentication-failures)
      - [Resolution](#resolution-2)
    - [Windows support](#windows-support)
    - [How to reset a AWS region when my terraform keeps failing](#how-to-reset-a-aws-region-when-my-terraform-keeps-failing)
    - [How to reset terraform & AWS](#how-to-reset-terraform--aws)
  - [How to avoid having to add AWS Key/Secret](#how-to-avoid-having-to-add-aws-keysecret)
  - [To do](#to-do)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



## Description
Terraform will deploy a EC2 instance with [cp-demo](https://github.com/confluentinc/cp-demo) repository or [kafka-docker-playground](https://github.com/vdesabou/kafka-docker-playground).

## Prerequisites
- Terraform 1.0.7
- Access to AWS account and gather key/secret


## How to run
1) Modify the `terraform.tfvars` file with the required variables
2) `terraform init` <- Downloads the necessary dependencies
3) `terraform plan` <- Validate required module variables have been set
4) `terraform apply` <- Deploys EC2 environment with the scripts setup
5) `terraform output` <- Shows the variables such as hostname/ssh command to run.
6) `terraform destroy` <- Destroys the old EC2 instance and cleans up local SSH keys

## Useful output from terraform
After running `terraform apply` you can use the following outputs to connect to your EC2 instance:
```
key_pair_name = "pops_ssh_key"
public_hostnames = [
  "ec2-XX-XX-XXX-XXX.eu-west-3.compute.amazonaws.com",
]
random_string = "pops_ssh_key"
security_group_name = "pops_sg"
ssh_command = "ssh -i ~/.ssh/pops_ssh_key ec2-user@ec2-XX-XX-XXX-XXX.eu-west-3.compute.amazonaws.com"
ssh_key_path_linux = "~/.ssh/pops_ssh_key"
ssh_key_path_windows = "~/.ssh/pops_ssh_key"
```
If you need the above output again, simply run `terraform output`.

## Variables

|Property | Documentation| Default | Required? |
| ------- | ------------ | ------- | --------- |
| aws_region | AWS region | | yes |
| aws_secret_access_key | Specifies the secret key associated with the access key. | | yes |
| aws_access_key_id | Specifies an AWS access key associated with an IAM user or role. | | yes |
| security_group_name | Security group name that gets attached to your EC2 instance| | yes |
|key_pair_name | SSH key name which gets generated locally and uploaded to AWS. | | yes |
|ami | Amazon image used when deploying EC2, currently only RHEL 7 is supported. | | yes|
|type_instance| Type of EC2 instance https://aws.amazon.com/ec2/instance-types/ | t3a.xlarge | yes |
| ec2_name | Name of your EC2 instance | | yes |
|shell_script_name| Name of the shell script to get executed from /tmp/scripts/exec | vincents_demo, cp-demo| no |
|user | User used for logging into EC2 and executing scripts. | ec2-user | no|


## Working AMI and EC2 type instace on a per region basis.
---
**NOTE**

The following tested AMIs, instance types, and regions work under the assumption each region will continue to have these instance types/AMIs. 

---

| Name | AMI | Region | Instance Type | OS | Verified| Tested? |
| ---- | --- | ------ | ------------- | -- | --------| ------ |
| US East (N. Virginia) | ami-005b7876121b7244d | us-east-1 | t3a.large  | RHEL | yes |
| US East (N. Virginia) | ami-005b7876121b7244d | us-east-1 | t3a.xlarge | RHEL | yes | 
| US East (Ohio) |  ami-0d2bf41df19c4aac7 | us-east-2 | t3a.large  | RHEL | yes | 
| US East (Ohio) | ami-0d2bf41df19c4aac7 | us-east-2 | t3a.xlarge | RHEL | yes | 
| US West (N. California) | ami-015474e24281c803d | us-west-1 | t3a.large  | RHEL | yes |
| US West (N. California) | ami-015474e24281c803d | us-west-1 | t3a.xlarge | RHEL | yes |
| US West (Oregon) | ami-02d40d11bb3aaf3e5 | us-west-2 | t3a.large | RHEL | yes |
| US West (Oregon) | ami-02d40d11bb3aaf3e5 | us-west-2 | t3a.xlarge | RHEL | yes |
| Asia Pacific (Hong Kong) | n/a |ap-east-1 | t3a.large | RHEL | no, AMI found for RHEL |
| Asia Pacific (Hong Kong) | n/a |ap-east-1 | t3a.xlarge | RHEL | no, AMI found for RHEL |
| Asia Pacific (Mumbai) | ami-0b6d1128312a13b2a | ap-south-1 | t3a.large | RHEL | yes |
| Asia Pacific (Mumbai) |  ami-0b6d1128312a13b2a | ap-south-1 | t3a.xlarge | RHEL | yes |
| Asia Pacific (Osaka) | ami-00718a107dacde79f | ap-northeast-3 | t3a.large | RHEL | no - Limited GA images(1) |
| Asia Pacific (Osaka) | ami-00718a107dacde79f | ap-northeast-3 | t3a.xlarge | RHEL | no - Limited GA images(1) |
| Asia Pacific (Seoul) | ami-0c851e892c33af909 | ap-northeast-2 | t3a.large | RHEL | yes |
| Asia Pacific (Seoul) | ami-0c851e892c33af909 | ap-northeast-2 | t3a.xlarge | RHEL | yes |
| Asia Pacific (Singapore) | ami-0f24fbd3cc8531844 | ap-southeast-1 | t3a.large | RHEL | yes |
| Asia Pacific (Singapore) | ami-0f24fbd3cc8531844 | ap-southeast-1 | t3a.xlarge | RHEL | yes |
| Asia Pacific (Sydney) | ami-0fb87e863747a1610 | ap-southeast-2 | t3a.large | RHEL | yes |
| Asia Pacific (Sydney) | ami-0fb87e863747a1610 | ap-southeast-2 | t3a.xlarge | RHEL | yes |
| Asia Pacific (Tokyo) | ami-0155fdd0956a0c7a0 | ap-northeast-1 | t3a.large | RHEL | no - missing subnet |
| Asia Pacific (Tokyo) | ami-0155fdd0956a0c7a0 | ap-northeast-1 | t3a.xlarge | RHEL |no - missing subnet |
| Canada | (Central) | ami-0de9a412a63b8f99d | ca-central-1 | t3a.large | RHEL | yes |
| Canada | (Central) | ami-0de9a412a63b8f99d | ca-central-1 | t3a.xlarge | RHEL | yes |
| Europe | (Frankfurt) | ami-0f58468b80db2db66 | eu-central-1 | t3a.large | RHEL | yes |
| Europe | (Frankfurt) | ami-0f58468b80db2db66 | eu-central-1 | t3a.xlarge | RHEL | yes |
| Europe | (Ireland) | ami-020e14de09d1866b4 | eu-west-1 | t3a.large | RHEL | yes |
| Europe | (Ireland) | ami-020e14de09d1866b4 | eu-west-1 | t3a.xlarge | RHEL | yes |
| Europe | (London) | ami-0e6c172f77df9f9c3 | eu-west-2 | t3a.large | RHEL | yes |
| Europe | (London) | ami-0e6c172f77df9f9c3 | eu-west-2 | t3a.xlarge | RHEL | yes |
| Europe | (Milan) | n/a | eu-south-1 | t3a.large | RHEL | no, AMI found for RHEL |
| Europe | (Milan) | n/a | eu-south-1 | t3a.xlarge | RHEL | no, AMI found for RHEL|
| Europe | (Paris) | ami-0f4643887b8afe9e2 | eu-west-3 | t3a.large | RHEL | yes |
| Europe | (Paris) | ami-0f4643887b8afe9e2 | eu-west-3 | t3a.xlarge | RHEL | yes |
| Europe | (Stockholm) | ami-003fb5b0ea327060c | eu-north-1 | t3a.large | RHEL | no - region instance types are too expensive |
| Europe | (Stockholm) | ami-003fb5b0ea327060c | eu-north-1 | t3a.xlarge | RHEL | no - region instance types are too expensive |


## Architecture
There are four modules which get created:
- initialization - generates SSH keys, deploys them to AWS, and creates SG for EC2
- devBox - deploys EC2 where we attach the SG,key pair, and run our setup scripts
- post_initialization - modifies the `~/.ssh/config` where we replace the UNKNOWN with hostname
- cleanup - after deleting from AWS SG, key pair, and EC2 we remove the old ssh keys and undo `~/.ssh/config` modifications





## Common issue

### Duplicate EC2 key pair
```
│ Error: Error import KeyPair: InvalidKeyPair.Duplicate: The keypair 'pops_ssh_key' already exists.
│       status code: 400, request id: 92f22a57-2839-453a-a475-2f6c67c0f507
│
│   with module.initialization.aws_key_pair.deployer,
│   on module/initialization/main.tf line 30, in resource "aws_key_pair" "deployer":
│   30: resource "aws_key_pair" "deployer" {
```
#### Resolution
The above error indicates there's duplicate ssh keys deployed to EC2.  

1) Run `terraform destroy`
2) Go to AWS UI
3) Select your region
4) Select EC2 service
5) Navigate on the left part `Key Pairs`
6) Search for your key name(defined as `key_pair_name`)
7) Delete this key and redeploy your instance

### AWS Key/Secret are misconfigured

```
│ Error: error configuring Terraform AWS Provider: error validating provider credentials: error calling sts:GetCallerIdentity: InvalidClientTokenId: The security token included in the request is invalid.
│       status code: 403, request id: 0fa344f5-c898-4123-848b-e3b20d086aaf
│
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on main.tf line 1, in provider "aws":
│    1: provider "aws" {
│
```
#### Resolution
Add missing key/secret for AWS in `terraform.tfvars`

### Too many authentication failures
```
➜ ssh -i ~/.ssh/pops_ssh_key ec2-user@ec2-13-212-46-167.ap-southeast-1.compute.amazonaws.com
The authenticity of host 'ec2-13-212-46-167.ap-southeast-1.compute.amazonaws.com (13.212.46.167)' can't be established.
ECDSA key fingerprint is SHA256:JQrnPJenMd1bFHI9nlO9Jx6XWxGjeWmcQw0FFQE2OS4.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ec2-13-212-46-167.ap-southeast-1.compute.amazonaws.com,13.212.46.167' (ECDSA) to the list of known hosts.
Received disconnect from 13.212.46.167 port 22:2: Too many authentication failures
Disconnected from 13.212.46.167 port 22
```
#### Resolution

1) `ps -ef | grep ssh`
2) `kill -9 [ssh-agent]`
3) rerun ssh command

### Windows support
- Windows integration has not been tested. The logic for generating the SSH keys and deleting them is there however scripts have not been completed. For the time being this will need to be run in WSL. 

### How to reset a AWS region when my terraform keeps failing


1) `terraform destroy` <- cleans up local keys
2) Go to AWS UI
3) Select your region in the top left corner
4) Select EC2 as the service
5) Terminate your EC2 instance
6) Go to `Key Pairs`


### How to reset terraform & AWS
1) `terraform destroy` <- cleans up local keys
2) Go to AWS UI
3) Select your region in the top left corner
4) Select EC2 as the service
5) Terminate your EC2 instance
6) Go to `Key Pairs`, find your key name and delete it
7) Go to `Security Groups`, find your group name and delete it


## How to avoid having to add AWS Key/Secret
If you do not wish to input the AWS Key/Secret in `terraform.tfvars`, the following steps will need to be taken:
1) [Setup AWS CLI](https://aws.amazon.com/cli/)
2) [Login to AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
3) Comment out or delete the following lines in `main.tf`:

```
# access_key = var.aws_access_key_id
# secret_key = var.aws_secret_access_key
```
4) Comment out or delete the following lines in `variables.tf`:

```
# variable "aws_secret_access_key"{
#     type = string
#     description = "AWS Secret Access Key"
# }

# variable "aws_access_key_id"{
#     type = string
#     description = "AWS Access key"
# }
```
5) Comment out or delete the following lines in `terraform.tfvars`:
```
# aws_secret_key=
# aws_access_key=
```


## To do
- [ ] Add module for creating EC2 instances and deploying using ansible.
- [ ] Add module for creating EC2 instances wher K8 is installed and deploying operator
- [ ] Add module for replicating customers data by passing in a schema, value, and data type.
- [ ] Add VPC integration including NACLs
- [ ] Enable VPC peering for replicating fruther environments.
- [ ] Deploy multiple instances for multiple customer replication envs.
- [ ] Add latency between environments to help replicate customers environments further. 


