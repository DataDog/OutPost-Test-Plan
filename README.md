#### For OutPost Version

**v1.3**

Solution Overview
___
### Partner name:
[Datadog](https://www.datadoghq.com/)

###  Industry vertical:
Monitoring and Observability

###  Brief description of solution:
Datadog is a SaaS-based monitoring and analytics platform for large-scale applications and infrastructure. Combining real-time logs, metrics from servers, containers, databases, and applications with end-to-end tracing, Datadog delivers actionable alerts and powerful visualizations to provide full-stack observability. Datadog includes over 400 vendor-supported integrations and APM libraries for several languages.

###  Customer use case for running the solution on Outposts:
Customers running services on Outposts will have the need to not only monitor the health and performance of those services (eg. EKS clusters, EC2 instances, RDS databases etc.) but also the applications they run on them. Datadog can monitor technologies on Outposts, as well as customer's own on-prem infrastructure, and provide a single consolidated place to view and analyze the data from every part of their technology stack.

### Existing AWS Marketplace offering:
_If yes provide a link to the marketplace offering_

Yes, Datadog products can be found on the [AWS Marketplace here](https://aws.amazon.com/marketplace/seller-profile?id=e56c35d0-c5d4-4dac-91d5-ebf57fef6e5c)

### Has the product been tested on EKS?
Yes, Datadog has an official integration with EKS. More information can be found on:
* [Docs page](https://docs.datadoghq.com/integrations/amazon_eks/)
* [Blog post](https://www.datadoghq.com/blog/eks-monitoring-datadog/)

###  AWS services the solution requires locally on Outposts:
For EKS:
* EKS
* EC2
* Any other services being used, eg. ELB, AppMesh

### AWS services the solution will need to access from the AWS Cloud:
* IAM
* CloudWatch

### Has an architecture diagram of the solution on Outposts been created ?
_If Yes. Attach image to test plan._

Yes, EKS integration [architecture diagram here](https://imgix.datadoghq.com/img/blog/eks-monitoring-datadog/eks-monitoring-datadog-cluster-agent.png)

### Any reason why more than (1) Outpost rack will be needed for your test?
_If so provide a brief description why and refer to test plan._

No, only one should be required.
___

# Test Plan

### Summary of test objectives and acceptance criteria:
Objectives:
1. Create a basic EKS cluster
2. Launch one EC2 instance as a bastion host used to install/configure the Datadog Agents
3. Install Datadog Container Agent on EKS cluster containers
4. Install Datadog node-based Agent on EC2 instances

Acceptance Criteria:
1. Success is achieved when metrics and logs about the EKS environment are visible on Datadog's default dashboards

### Test environment details:

#### EKS NodeGroup
*  2 EC2 instances

#### IAM Roles
* 1 IAM Role with policy that has the required permissions to query the CloudWatch API for metrics
    * This is required for Datadog to query CloudWatch metrics

#### VPC
* 1 new VPC for the test EKS cluster
------

### Test 1 description:
Create a basic EKS cluster, setup the Datadog Cluster Agent and datadog node-based Agent. Finally, verify metrics and logs are visible in Datadog.

### Test 1 steps:
**1. Create a basic EKS cluster using `eksctl`**
```
eksctl create cluster
```
A cluster will be created with default parameters:

- auto-generated name, e.g. "fabulous-mushroom-1527688624"
- 2x m5.large nodes
- use official AWS EKS AMI
- us-west-2 region
- dedicated VPC
- using static AMI resolver

**2. Configure RBAC permissions for the Cluster Agent and node-based Agents**

Use the included `cluster-agent-rbac.yaml`, `datadog-rbac.yaml` to deploy

```
$ kubectl apply -f /path/to/cluster-agent-rbac.yaml
$ kubectl apply -f /path/to/datadog-rbac.yaml
```

**3. Secure communication between node-based Agents and the Cluster Agent**

Generate a secret token to use in the included `dca-secret.yaml` file (replace `<TOKEN>` value):
```
echo -n '<32_CHARACTER_LONG_STRING>' | base64
vi /path/to/dca-secret.yaml
```

Create the secret:
```
$ kubectl apply -f /path/to/dca-secret.yaml
```

**4. Create and deploy the Cluster Agent manifest**

Use the included `datadog-cluster-agent.yaml` file (replace `<YOUR_API_KEY>` with Datadog API key)
```
$ kubectl apply -f /path/to/datadog-cluster-agent.yaml
```

* Deploy the node-based Agent DaemonSet
Use the included `datadog-agent.yaml` file (replace `<YOUR_API_KEY>` with Datadog API key)
```
$ kubectl apply -f /path/to/datadog-agent.yaml
```

**5. Setup CloudWatch**

* Create a new role in the AWS IAM Console and attach a policy that has the required permissions to query the CloudWatch API for metrics

* In Datadog, configure the [AWS Integration Tile](https://app.datadoghq.com/account/settings#integrations/amazon_web_services) with:
    * AWS Account ID
    * Role Name
    * Tick the boxes for: "EC2", "EC2 API", "EC2 Spot Fleet" and "EBS"


### Test 1 success criteria:
* Navigate to Datadog and verify dashboard contains EKS metrics

___

# If applicable add more test cases for other software products

### Test 2 description:

### Test 2 steps:

### Test 2 success criteria:
