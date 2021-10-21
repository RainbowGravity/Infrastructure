# Inftastructure
## About
Template in this folder is used for AWS ECS Cluster deployment. Template is creating VPC, ECS Cluster and EC2 Instances for it. ECS Services are named as Blue, Green and Dev. 

* Blue - main service. Name Blue is stands for stable current version.
* Green - new updated version of service which is ready for deployment, but need to be tested in production.
* Dev - new version which is not tested before and need to be deployed as dedicated service for pre-production tests.

## Infrastructure
Terraform template consists of several directories created for every resource. It allows to create, change or destroy resources separately. Each created resource have its own remote state in the S3 Bucket with DynamoDB locking. 

In implemented workflows each resource is created automatically in Github Actions workflows. Creation or destruction of the resources can be triggered automatically by PRs & pushes or manually with workflow dispatch.

AWS ECS Cluster based on AWS EC2 Auto Scaling group. There is a AWS CloudWatch alarms about CPU & memory utilization which allows to scale ECS Instances under heavy load. Same for the Green and Blue services. 

Auto Scaling group ECS Instances are placed in private subnets, so there are several Endpoints for ECS, ECR, S3 and SSM services. Without them cluster will not be able to see instances and upload images to them. Same for the SSM which allows to connect to instances without an SSH bastion host.

<p align=center><b>Infrastructure diagram</b></p>
<p align=center>

  <img width="800" height="931" src="https://user-images.githubusercontent.com/89798605/138357910-b5b12e4e-1b0e-4415-9607-0cb35e2293fa.png">

 
</p>

## ECS Services

Traffic between Blue and Green services can be specified by one of the five presets: blue, blue-80, split, green-80 and green. There is Github Actions workflow called “Redirect Traffic” which allows to do it without interactions with CLI.

Every ECS Service have different listeners. If you want to test Green or Dev, then connect to the ALB via 8080 or 9090 port. 

AWS CloudWatch alarms allows to monitor CPU & memory usage of the services and take Auto Scaling actions if one of the metrics is >80% usage.

<p align=center><b>ECS Services diagram</b></p>
<p align=center>

  <img width="800" height="571" src="https://user-images.githubusercontent.com/89798605/138358325-f80f9651-f479-43fa-bbac-91d2938c4ad0.png">

 
</p>

