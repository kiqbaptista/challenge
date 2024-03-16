
# API CHALLENGE

This repository contains all files to crearte all necessary resources in Azure Cloud to deploy an API .NET CORE.




## Installation

Install and configure credentials with Azure Cloud and AZ CLI to run locally.

```bash
terraform init
terraform plan 
terraform apply
```


PS: The challenged was not concluded with all exigencies. 

I couldn`t find a sample API which uses Database for persistency.

All resources were created using terraform best practices and reusable modules.

Pipeline created with GitHub Actions for provisioning terraform infrastructure and build and push application so can be usable for ArgoCD.

The deployment and service using loadbalancer are creating by Helm Charts that can be stored remotely.

ArgoCD installed using helm and Makefile for easy retrieving of initial UI Password.