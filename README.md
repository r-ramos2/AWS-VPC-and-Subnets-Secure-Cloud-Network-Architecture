# **AWS VPC and Subnets - Secure Cloud Network Architecture**

## **Project Overview**

This project focuses on the creation and configuration of a secure AWS Virtual Private Cloud (VPC), which includes public and private subnets, routing, security groups, and monitoring. It implements routing, access control, and monitoring to ensure a secure cloud architecture. By utilizing Infrastructure as Code (IaC) with Terraform, the architecture can be automated and maintained for scalability and consistency. It demonstrates the capabilities of building and securing AWS networks while adhering to cloud security best practices.

<img width="926" alt="vpc_architecture" src="https://github.com/user-attachments/assets/2f8b9d32-d594-4104-83a1-2bd42e9818d8">

*Architecture Diagram*

---

## **Table of Contents**
1. [Introduction](#introduction)
2. [Project Goals](#project-goals)
3. [Prerequisites](#prerequisites)
4. [Step-by-Step Guide](#step-by-step-guide)
   - [Manual AWS VPC and Subnet Setup](#manual-aws-vpc-and-subnet-setup)
   - [Terraform Automation for VPC and Subnets](#terraform-automation-for-vpc-and-subnets)
   - [Network Security Enhancements](#network-security-enhancements)
   - [Monitoring and Logging](#monitoring-and-logging)
5. [How to Run Terraform Files](#how-to-run-terraform-files)
6. [Conclusion](#conclusion)
7. [References](#references)
8. [Terraform Files](#terraform-files)

---

## **Introduction**

As organizations migrate to cloud environments, securing the underlying infrastructure becomes crucial. This project focuses on designing a **Virtual Private Cloud (VPC)** on AWS with public and private subnets. It implements **routing**, **access control**, and **monitoring** to ensure a **secure cloud architecture**. Additionally, **Infrastructure as Code (IaC)** is used with **Terraform** to automate and maintain the architecture for scalability and consistency.

This comprehensive approach not only helps secure cloud environments but also demonstrates proficiency in automating infrastructure using **Terraform**—an essential skill in modern cloud security roles.

---

## **Project Goals**

1. **Create a VPC** with public and private subnets using both manual setup and Terraform automation.
2. **Establish secure routing** with proper traffic segmentation.
3. Implement **least-privilege security groups** for public and private subnets.
4. Enable **VPC Flow Logs** for monitoring and auditability.
5. **Automate infrastructure** using Terraform, ensuring reusability and scalability.
6. Adhere to **AWS cloud security best practices** in designing and managing cloud networks.

---

## **Prerequisites**

- **AWS Account** with permissions to create VPCs, subnets, security groups, and routing tables.
- **Terraform** (version 1.0 or later) installed locally.
- Basic knowledge of AWS networking (VPC, CIDR blocks, subnets) and Terraform syntax.
- An IAM role with appropriate permissions for creating and managing AWS resources (VPC, EC2, S3, etc.).

---

## **Step-by-Step Guide**

### **Manual AWS VPC and Subnet Setup**

The following steps outline how to manually create a VPC and configure subnets using the **AWS Management Console**.

#### **1. Create a VPC**
1. Log in to your **AWS Management Console**.
2. In the search bar, type **VPC** and navigate to the **VPC Dashboard**.
3. Click **Create VPC**.
4. Under **VPC Only**, name your VPC `my-secure-vpc`.
5. Choose **IPv4 CIDR block** as **Manual Input** and enter `10.0.0.0/16`. This allocates a block of 65,536 IP addresses for your VPC.
6. Set **IPv6 CIDR block** to **No IPv6 CIDR Block**.
7. Select **Default Tenancy** (this ensures lower costs).
8. Click **Create VPC**.

#### **2. Create Subnets**
Subnets allow you to divide the VPC into smaller networks. We will create both a **public subnet** and a **private subnet**.

1. Navigate to **Subnets** in the left-hand menu.
2. Click **Create Subnet**.
3. Select your **VPC** (`my-secure-vpc`).
4. Create the **public subnet**:
   - **Subnet name**: `public-subnet-1a`
   - **Availability Zone**: Choose an availability zone (e.g., `us-east-1a`)
   - **IPv4 CIDR block**: `10.0.0.0/24` (256 IP addresses for the public subnet)
5. Click **Create Subnet**.
6. Repeat the steps to create the **private subnet**:
   - **Subnet name**: `private-subnet-1b`
   - **Availability Zone**: Choose another zone (e.g., `us-east-1b`)
   - **IPv4 CIDR block**: `10.0.1.0/24` (256 IP addresses for the private subnet)

#### **3. Create an Internet Gateway**
The **Internet Gateway (IGW)** allows communication between your VPC and the public internet.

1. Navigate to **Internet Gateways** on the left menu.
2. Click **Create Internet Gateway** and name it `my-secure-igw`.
3. Attach the IGW to `my-secure-vpc`.

#### **4. Create Route Tables**
We need to define how traffic will be routed within the VPC.

1. Navigate to **Route Tables**.
2. Create a **Public Route Table**:
   - Name: `public-route-table`
   - Associate the IGW to allow internet access:
     - **Destination CIDR**: `0.0.0.0/0` (allow all traffic)
     - **Target**: Internet Gateway (select `my-secure-igw`)
3. Associate this route table with the **public subnet** (`public-subnet-1a`).

4. Create a **Private Route Table**:
   - Name: `private-route-table`
   - This route table does not need an internet route since private subnets do not have external internet access.
5. Associate this route table with the **private subnet** (`private-subnet-1b`).

---

### **Terraform Automation for VPC and Subnets**

Terraform is used to automate the creation of the VPC, subnets, route tables, security groups, and more. The full Terraform code is not displayed here, but it is included in separate files as part of the repository:

- `vpc.tf`: Defines the VPC and Internet Gateway.
- `subnet_route.tf`: Configures subnets and route tables.
- `security_groups.tf`: Sets up security groups for controlling traffic.
- `flow_logs.tf`: Configures VPC Flow Logs for monitoring.

For details, refer to the respective `.tf` files in this repository, which can be executed to automate the infrastructure setup.

---

## **How to Run Terraform Files**

To properly run the Terraform files, follow these steps:

1. **Install Terraform**: Ensure you have Terraform installed on your local machine. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).

2. **Configure AWS Credentials**: Set up your AWS credentials to allow Terraform to manage resources. You can do this by configuring the AWS CLI or creating a `~/.aws/credentials` file with the following format:
   ```plaintext
   [default]
   aws_access_key_id = YOUR_ACCESS_KEY
   aws_secret_access_key = YOUR_SECRET_KEY
   region = YOUR_AWS_REGION
   ```

3. **Navigate to Your Project Directory**: Open your terminal and change to the directory where your Terraform files are located.

4. **Initialize Terraform**: Run the following command to initialize Terraform and download the necessary provider plugins:
   ```bash
   terraform init
   ```

5. **Validate the Configuration**: Check your Terraform configuration for syntax errors:
   ```bash
   terraform validate
   ```

6. **Plan the Deployment**: Generate and review an execution plan to see what actions Terraform will take:
   ```bash
   terraform plan
   ```

7. **Apply the Configuration**: Deploy the infrastructure by applying the configuration:
   ```bash
   terraform apply
   ```
   You will be prompted to confirm the changes. Type `yes` and press Enter.

8. **Monitor Deployment**: Watch the output in the terminal for any errors or confirmation of resource creation.

9. **Destroy Resources**: If you need to tear down the resources created, you can run:
   ```bash
   terraform destroy
   ```
   Again, confirm by typing `yes`.

By following these steps, you'll be able to effectively manage your AWS infrastructure using Terraform, which is a crucial skill in AWS cloud security roles.

---

### **Network Security Enhancements**

1. **Security Groups**: Ensure **least-privilege access**. Use one security group for public subnets (allow HTTP/HTTPS) and another for private subnets (restrict access to SSH from within the VPC). This minimizes the attack surface.

2. **NAT Gateway** (Optional): If you need private subnets to have internet access for outbound connections, configure a NAT Gateway. This allows resources in the private subnet to reach the internet while keeping them secure from incoming traffic.

3. **IAM Role Creation**: Create an IAM role with the necessary permissions for Terraform to manage AWS resources. You can refer to the [AWS IAM Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) for guidance on creating and attaching policies.

---

### **Monitoring and Logging**

#### **VPC Flow Logs**

- **VPC Flow Logs** allow you to monitor network traffic in and out of your VPC, capturing accepted and rejected traffic. The logs are critical for compliance and security auditing. You can store these logs in an S3 bucket or send them to CloudWatch Logs for further analysis.

---

## **Conclusion**

This project illustrates the complete process of creating a secure and scalable AWS cloud network architecture through both manual setup and automation via Terraform. The emphasis is placed on network isolation, least-privilege access control, and effective monitoring through VPC Flow Logs. The implementation of best practices in security and network design ensures that the architecture is robust and resilient against potential threats. By following this guide, the project establishes a solid foundation in AWS networking, while also showcasing the automation of infrastructure creation, which is essential in today’s cloud environments.

---

## **References**
1. [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
2. [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
