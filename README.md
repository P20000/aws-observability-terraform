# Cloud-Native Observability Stack ☁️
**Automated AWS Infrastructure with Terraform, CloudWatch, and Python**

## 🎯 Project Overview
This project demonstrates a production-ready infrastructure-as-code (IaC) setup designed to bridge the gap between application development and cloud operations. It provisions a secure, monitored, and cost-optimized environment on AWS.

## 🏗️ Architecture
- **VPC Layer:** Modular VPC with Public/Private subnets across multiple AZs.
- **Compute:** Ubuntu 24.04 EC2 instances bootstrapped with automated User Data scripts.
- **Security:** Strict Security Group rules for SSH (22) and HTTP (80).
- **Observability:** CloudWatch Dashboards and CPU Utilization Alarms.
- **Automation:** Python (Boto3) script for identifying orphaned resources to reduce cloud waste.

## 🛠️ Tech Stack
- **IaC:** Terraform
- **Cloud:** AWS (EC2, VPC, CloudWatch, IAM)
- **Scripting:** Python 3.x, Boto3, Bash
- **OS:** Ubuntu Server

## 🚀 How to Deploy
1. **Initialize:** `terraform init`
2. **Plan:** `terraform plan`
3. **Apply:** `terraform apply`
4. **Optimize:** `source venv/bin/activate && python cost_optimizer.py`

## 📈 Monitoring & Cost Results
- **Dashboard:** Provides a single-pane-of-glass view of instance health.
- **Cost Savings:** The Boto3 script identifies unattached Elastic IPs which can save ~$3.60/month per address in waste.