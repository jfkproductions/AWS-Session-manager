### Short desscription 
What is Session Manager?
AWS Systems Manager Session Manager is a service that allows you to manage your EC2 instances securely without using SSH keys or bastion hosts. It provides a browser-based or AWS CLI-based interface for accessing your instances.

Benefits:


No SSH Keys: Eliminates the need for managing and distributing SSH keys.
Logging and Auditing: All session activity is logged in AWS CloudTrail, providing a detailed audit trail.
Ease of Access:

Centralized Access: Manage multiple instances from a single interface.
Browser and CLI Access: Use either a web browser or AWS CLI to start sessions.
Compliance and Governance:

Control and Monitor Access: Fine-grained access control and detailed logging help meet security and compliance requirements.
No Need for Public IPs:

Instances do not need a public IP address, reducing the exposure to the internet.



## Steps to Connect to Your AWS Instance and Manage Terraform Workspace

### Prerequisites
- Ensure you have AWS CLI installed and configured.
- Ensure you have Terraform installed.

### Step 1: Connect to Your AWS Instance
You can use tools like Leapp or AWS CLI to connect to your AWS instance.

#### Using AWS CLI
1. List your S3 buckets to verify your AWS CLI configuration:
   ```sh
   aws s3 ls

### Create a new Terraform workspace

terraform workspace new dev
### Use the Latest Amazon Linux 2 AMI
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images[*].[ImageId,Name]" --output table


### update ami 
resource "aws_instance" "Ec2SessionManager" {
  ami                  = "ami-0c55b159cbfafe1f0" # use the latest Amazon Linux 2 AMI or one
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  tags = {
    Name = "Ec2SessionManager delete when done"
  }
}


#### Plan and deploy 
terraform plan
terraform apply

### Remember to destroy after wards 
terraform destroy
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.session_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.session_manager_ec2_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | The availability zones for the subnets | `list(string)` | <pre>[<br>  "eu-central-1a",<br>  "eu-central-1b"<br>]</pre> | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_customer_name"></a> [customer\_name](#input\_customer\_name) | n/a | `string` | `"Demo Customer"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"Dev"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The CIDR blocks for the private subnets | `list(string)` | <pre>[<br>  "10.0.3.0/24",<br>  "10.0.4.0/24"<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `"Demo Project"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The CIDR blocks for the public subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | `"Demo-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |

## Architecture
```mermaid 
flowchart TB
    subgraph VPC [VPC]
        hVPC[-VPC-]:::type
        dVPC[Manages VPC resources]:::description
        VPCResource[aws_vpc.Demo-vpc]:::component
        PublicSubnet1[aws_subnet.public_subnet_1]:::component
        PublicSubnet2[aws_subnet.public_subnet_2]:::component
        PrivateSubnet1[aws_subnet.private_subnet_1]:::component
        PrivateSubnet2[aws_subnet.private_subnet_2]:::component
        SecurityGroupInstance[aws_security_group.instance]:::component
        SecurityGroupSessionManager[aws_security_group.session_manager_ec2_sg]:::component

        subgraph IAM [IAM]
            hIAM[-IAM-]:::type
            dIAM[Manages access policies]:::description
            IAMInstanceProfile[aws_iam_instance_profile.ssm_instance_profile]:::component
            IAMRole[aws_iam_role.ssm_role]:::component
            IAMRolePolicyAttachment[aws_iam_role_policy_attachment.ssm_role_policy_attachment]:::component
        end

        subgraph EC2 [EC2]
            hEC2[-EC2-]:::type
            dEC2[Manages EC2 instances]:::description
            EC2Instance[aws_instance.Ec2SessionManager]:::component
        end
    end

    %% Connections
    VPCResource --> PublicSubnet1
    VPCResource --> PublicSubnet2
    VPCResource --> PrivateSubnet1
    VPCResource --> PrivateSubnet2
    PublicSubnet1 --> SecurityGroupInstance
    PublicSubnet2 --> SecurityGroupInstance
    PrivateSubnet1 --> SecurityGroupSessionManager
    PrivateSubnet2 --> SecurityGroupSessionManager
    SecurityGroupSessionManager --> EC2Instance
    IAMInstanceProfile --> EC2Instance
    IAMRole --> IAMInstanceProfile
    IAMRolePolicyAttachment --> IAMRole

    %% Styling definitions
    classDef internalSystem fill:#1168bd,color:#fff,stroke:#333,stroke-width:2px;
    classDef externalSystem fill:#999999,color:#fff,stroke:#333,stroke-width:2px;
    classDef type stroke-width:0px,color:#fff,fill:transparent,font-size:12px;
    classDef description stroke-width:0px,color:#fff,fill:transparent,font-size:13px;
    classDef component fill:#add8e6,color:#000,stroke:#333,stroke-width:1px;
    classDef lightBackground fill:#f8f8f8,color:#000,stroke:#333,stroke-width:1px;

    %% Apply styles to headers and descriptions
    class hIAM,hEC2,hVPC type;
    class dIAM,dEC2,dVPC description;

    %% Apply light background to subgraphs except VPC
    class IAM,EC2 lightBackground;
    ```