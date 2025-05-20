# VPC Networking Infrastructure Lab

This repository documents my implementation of the "VPC Networking Infrastructure" lab, where I deployed and managed a Jenkins Continuous Integration environment using Google Cloud Marketplace.

## Video

https://youtu.be/ISoByt6iDOk


## Overview

In this project, I used Google Cloud Marketplace to rapidly deploy a sophisticated Jenkins CI environment, demonstrating the power of Google Cloud infrastructure services. The deployment was handled by Deployment Manager, which automatically provisioned the necessary resources and configured the software.

## Objectives Achieved

- ✅ Used Google Cloud Marketplace to deploy a Bitnami Jenkins CI environment
- ✅ Verified management capabilities through the Jenkins UI
- ✅ Administered the service from the Virtual Machine host via SSH

## Architecture

The deployment consists of:
- A Google Compute Engine VM instance running Jenkins
- Preconfigured firewall rules to allow traffic to Jenkins
- Bitnami's Jenkins package with all necessary dependencies

## Step-by-Step Implementation

### Task 1: Using Marketplace to Build a Deployment

1. Navigated to Google Cloud Marketplace via the Navigation menu
2. Searched for and selected "Bitnami package for Jenkins"
3. Reviewed the software package details and deployment requirements
4. Launched the deployment with the following configuration:
   - Deployment Service Account: Compute Engine default service account
   - Zone: As specified in the lab
   - Machine Type: E2 Series, e2-standard-2 (2 vCPU, 1 core, 8GB memory)
5. Deployed the package using Deployment Manager, which:
   - Acquired a virtual machine instance
   - Installed and configured the software
   - Set up network firewall rules

### Task 2: Examining the Deployment

1. Retrieved the admin credentials from the deployment details
2. Accessed the Jenkins UI via the provided Site URL
3. Logged in using the admin credentials
4. Installed the suggested plugins when prompted
5. Explored the Jenkins management interface to verify functionality

### Task 3: Administering the Service

1. Accessed the VM instance via SSH from the Google Cloud Console
2. Managed Jenkins services using Bitnami control script:
   ```bash
   # To stop all services
   sudo /opt/bitnami/ctlscript.sh stop
   
   # To restart all services
   sudo /opt/bitnami/ctlscript.sh restart
   ```
3. Verified service status by refreshing the Jenkins UI after each operation

## Key Learnings

- Google Cloud Marketplace provides pre-configured templates using Deployment Manager
- Deployment Manager automates the allocation of Google Cloud resources and setup tasks
- Jenkins CI environment can be rapidly deployed and is fully manageable both through its UI and via SSH
- Bitnami packages simplify the deployment and management of complex applications

## Tools and Services Used

- **Google Cloud Platform**:
  - Google Cloud Marketplace
  - Deployment Manager
  - Compute Engine
  - Virtual Private Cloud (VPC)
  - Firewall Rules
- **Applications**:
  - Jenkins CI (Bitnami package)
  - SSH for server administration

## References

- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Bitnami Jenkins Documentation](https://docs.bitnami.com/google/apps/jenkins/)
