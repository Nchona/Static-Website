Terraform S3 Static Website with CloudFront and Route 53
This project provisions AWS infrastructure to host a static website using S3, CloudFront, and Route 53. The setup includes creating two S3 buckets (one for the website and one for assets), uploading dummy objects to each bucket, and configuring CloudFront and Route 53 for domain hosting.

Project Structure
css
Copy code
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules
│   └── s3-bucket
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
└── README.md
Root Module Files
main.tf: Defines the main infrastructure resources including CloudFront distribution and Route 53 records.
variables.tf: Contains the variable definitions for the root module.
outputs.tf: Specifies the outputs from the root module.
S3-Bucket Module Files
main.tf: Provisions the S3 buckets, uploads dummy objects, and configures bucket policies.
variables.tf: Contains the variable definitions for the S3-Bucket module.
outputs.tf: Specifies the outputs from the S3-Bucket module.
Prerequisites
Terraform installed.
AWS credentials configured. You can use the AWS CLI to configure your credentials.
Setup and Usage
1. Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/terraform-s3-static-website.git
cd terraform-s3-static-website
2. Initialize the Project
Initialize Terraform to download the necessary providers and modules.

bash
Copy code
terraform init
3. Configure Variables
Edit the variables.tf files in both the root module and the modules/s3-bucket module to set the required variables. You can also create a terraform.tfvars file to specify variable values.

Example terraform.tfvars:

hcl
Copy code
source_bucket_name = "my-source-bucket"
assets_bucket_name = "my-assets-bucket"
domain_name        = "example.com"
region             = "us-east-1"
4. Plan the Deployment
Generate an execution plan to see what changes will be made.

bash
Copy code
terraform plan
5. Apply the Configuration
Apply the Terraform configuration to create the infrastructure.

bash
Copy code
terraform apply
6. Outputs
After applying the configuration, Terraform will output useful information such as the S3 bucket IDs and CloudFront distribution details.

7. Clean Up
To destroy the infrastructure created by this project, run:

bash
Copy code
terraform destroy
Modules
S3-Bucket Module
The s3-bucket module handles the creation and configuration of the S3 buckets.

Inputs
source_bucket_name: The name of the source S3 bucket.
assets_bucket_name: The name of the assets S3 bucket.
Outputs
source_bucket_id: The ID of the source S3 bucket.
source_bucket_website_endpoint: The website endpoint of the source S3 bucket.
assets_bucket_id: The ID of the assets S3 bucket.
Additional Notes
Ensure the AWS credentials used have sufficient permissions to create S3 buckets, CloudFront distributions, and Route 53 records.
Modify the website_files and error_page resources in the s3-bucket module to customize the website content.
