# Installation Guide

This document provides a comprehensive guide for installing and configuring the Jenkins CI environment on Google Cloud Platform using Marketplace.

## Prerequisites

Before beginning the installation process, ensure you have:

- A Google Cloud Platform account with billing enabled
- Permissions to create resources in your project
- Basic familiarity with Google Cloud Console

## Installation Steps

### 1. Prepare Your Google Cloud Environment

1. Sign in to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Ensure the following APIs are enabled:
   - Compute Engine API
   - Deployment Manager API
   - Infrastructure Manager API

To enable these APIs:
```
Navigate to APIs & Services > Library
Search for each API by name
Click on each API and then click "Enable"
```

### 2. Deploy Jenkins from Marketplace

#### Navigate to Marketplace
1. In the Google Cloud Console, click on the navigation menu (☰)
2. Select "Marketplace"
3. Search for "Bitnami Jenkins"
4. Click on the "Bitnami package for Jenkins" result

#### Configure and Deploy
1. Click "Get Started"
2. Review the deployment details and click "Continue"
3. Accept the terms of service and click "Agree"
4. Click "Deploy"
5. Configure your deployment with the following settings:
   - **Deployment Name**: jenkins-1 (or your preferred name)
   - **Zone**: Choose a zone close to your location
   - **Machine Type**: e2-standard-2 (2 vCPU, 8GB memory)
   - **Boot Disk**: Leave as default (10GB Standard Persistent Disk)
   - **Deployment Service Account**: Select "Compute Engine default service account"
   - **Network**: Leave as default (default VPC network)
   - **IP**: Leave as default (creates a new ephemeral IP)
   - **Firewall**: Ensure "Allow HTTP traffic" and "Allow HTTPS traffic" are checked

6. Click "Deploy" to start the deployment process

### 3. Access Your Jenkins Instance

1. Once deployment is complete, go to the "Deployment Manager" page
2. Click on your Jenkins deployment (e.g., "jenkins-1")
3. On the deployment details page, note the following:
   - **Site URL**: The URL to access your Jenkins instance
   - **Admin user**: Username for Jenkins admin access
   - **Admin password**: Temporary password for Jenkins admin access

4. Click on the Site URL to open the Jenkins login page
5. Log in using the admin credentials provided

### 4. Initial Jenkins Configuration

1. After logging in for the first time, you may be prompted to customize Jenkins
2. Select "Install suggested plugins" and wait for the installation to complete
3. Click "Restart" after installation finishes
4. Log in again after Jenkins restarts
5. You can now start using Jenkins

## Post-Installation Setup

### Change the Default Admin Password

For security reasons, change the default admin password:

1. Click on "Manage Jenkins" in the left sidebar
2. Select "Manage Users"
3. Click on the gear icon next to the admin user
4. Click "Configure"
5. Enter and confirm a new password
6. Click "Save"

### Configure Backup

Set up regular backups of your Jenkins configuration:

1. Install the "ThinBackup" plugin:
   - Go to "Manage Jenkins" > "Manage Plugins"
   - Go to the "Available" tab
   - Search for "ThinBackup"
   - Select and install the plugin

2. Configure ThinBackup:
   - Go to "Manage Jenkins" > "ThinBackup"
   - Set up backup directory and schedule
   - Click "Save"

### Set Up Security

Enhance the security of your Jenkins instance:

1. Go to "Manage Jenkins" > "Configure Global Security"
2. Review and adjust security settings as needed
3. Consider enabling CSRF protection if not already enabled
4. Configure authentication based on your organization's requirements

## Troubleshooting

### Common Issues

#### Cannot Access Jenkins UI
- Ensure the VM is running
- Check if the URL is correct
- Verify that port 8080 is open in the firewall rules

#### Login Problems
- Verify you're using the correct credentials
- If you've lost the admin password, you can reset it via SSH:
  ```bash
  sudo cat /opt/bitnami/jenkins/credentials/initialAdminPassword
  ```

#### Service Not Starting
If Jenkins service doesn't start, try:
```bash
sudo /opt/bitnami/ctlscript.sh restart jenkins
```

## Maintenance

### Starting/Stopping Jenkins

To manage Jenkins service:

```bash
# Start all services
sudo /opt/bitnami/ctlscript.sh start

# Stop all services
sudo /opt/bitnami/ctlscript.sh stop

# Restart all services
sudo /opt/bitnami/ctlscript.sh restart

# Check status
sudo /opt/bitnami/ctlscript.sh status
```

### Updating Jenkins

Bitnami packages are configured to be updated with minimal effort:

1. Connect to your VM via SSH
2. Update the Bitnami stack:
   ```bash
   sudo /opt/bitnami/ctlscript.sh stop
   sudo apt-get update
   sudo apt-get upgrade bitnami-jenkins
   sudo /opt/bitnami/ctlscript.sh start
   ```

## Uninstallation

To remove the Jenkins deployment:

1. Go to "Deployment Manager"
2. Select your Jenkins deployment
3. Click "Delete"
4. Confirm the deletion

This will delete all resources associated with the deployment, including the VM instance and persistent disks.
