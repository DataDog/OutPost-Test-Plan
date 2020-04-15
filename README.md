<hr>

# Sample Test Plan for Outposts v1.3

#### For OutPost Version 

**v1.2**

Solution Overview
___
### Partner name:
[Falco](https://falco.org/docs/)

###  Industry vertical:
Security Software

###  Brief description of solution:
Falco is a behavioral activity monitor designed to detect anomalous activity in your applications. Falco audits a system at the most fundamental level, the kernel. Falco then enriches this data with other input streams such as container runtime metrics, and Kubernetes metrics.

###  Customer use case for running the solution on Outposts:
For the many customer running Kubernetes or containers on outposts, having realtime security, and monitoring is extremely important. With Outposts being connected back to on-premise datacenters having the abiity to audit kernal level signal calls can prevent bad actors before reaching key infrastructure.

### Existing AWS Marketplace offering:
If yes provide a link to the marketplacve offering
No marketplace offering, check out blog about how to install on AWS.
https://aws.amazon.com/blogs/opensource/securing-amazon-eks-lambda-falco/

### Has the been tested on EKS?
Yes Falco has developed an AWS solutions repo with fluent-bit Firelens integration on Github for EKS 1.12, 1.13, 1.14, and 1.15.
https://github.com/falcosecurity/falco-aws-firelens-integration

###  AWS services the solution requires locally on Outposts:
* EKS
* EC2
* EBS

### AWS services the solution will need to access from the AWS Cloud:
* IAM


### Has an architecture diagram of the solution on Outposts been created ?
If Yes. Attach image to test plan.

### Any reason why more than (1) Outpost rack will be needed for your test?
If so provide a brief description why and refer to test plan.
___

# Test Plan

### Summary of test objectives and acceptance criteria:
EKSctl will create four subnets (two “public”, two “private”) and launch (1) EC2 instance to perform an installation, configuration, and functionality test of ABC running on Outposts. One of the EKS instances will be installed with the Falco Daemonset, and one test applcation to collect data. Success will be determined when the falco data from the running outpost can be viewed via CLI from a client computer.

### Test environment details:

#### VPCS Subnets
* 2 “Public” subnet:
* 2 “Private” subnet:

#### EKS NodeGroup
*  2 EC2 instances: Linux Amazon Linux 2

#### IAM Roles
* 1 Iam Role for Falco Log aggregator to send logs to cloudwatch logs

------

### Test 1 description:
Create the subnets and launch EC2 instances for the infrastructure resources for the ABC environment and install ABC software components.

### Test 1 steps:
*	Create outpost 2 “Public” subnet
*	Create outpost 2 “Private” subnet
*	Replace VPC ID and Subnet ID's in eks/eks_cluster.yaml
*	cd into eks/
*	Run `make cluster` to deploy the EKS cluster
*	Run `deploy-iam` to deploy falco
*	Run `deploy-falco` to deploy falco
*	Run `deploy-fluent` to deploy falco
*	Run `deploy-app` to deploy sample application

### Test 1 success criteria:
* go to cloudwatch logs -> loggroups -> falco ... check logging and audit messages are showing up


___

# If applicable add more test cases for other software products

### Test 2 description:

### Test 2 steps:

### Test 2 success criteria: