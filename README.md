# Terraform S3 Static Website with CloudFront and Route 53

This Terraform project provisions AWS infrastructure to host a static website using S3, CloudFront, and Route 53. It includes creating two S3 buckets (one for the website and one for assets), uploading dummy objects to each bucket, and configuring CloudFront and Route 53 for domain hosting.

 ## Project Structure

```yml
├── main.tf
├── variables.tf
├── outputs.tf
├── modules
│   └── s3-bucket
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

#### Root Module Files
* main.tf: Defines the main infrastructure resources including CloudFront distribution and Route 53 records.
* variables.tf: Contains the variable definitions for the root module.
* outputs.tf: Specifies the outputs from the root module.

#### S3-Bucket Module Files
* main.tf: Provisions the S3 buckets, uploads dummy objects, and configures bucket policies.
* variables.tf: Contains the variable definitions for the S3-Bucket module.
*outputs.tf: Specifies the outputs from the S3-Bucket module.

#### Prerequisites
* Terraform installed.
* AWS credentials configured. You can use the AWS CLI to configure your credentials.


###  Modules
#### S3-Bucket Module
 * The s3-bucket module handles the creation and configuration of the S3 buckets.

#### Inputs
* source_bucket_name: The name of the source S3 bucket.
* assets_bucket_name: The name of the assets S3 bucket.
#### Outputs
 * source_bucket_id: The ID of the source S3 bucket.
 * source_bucket_website_endpoint: The website endpoint of the source S3 bucket.
 * assets_bucket_id: The ID of the assets S3 bucket.

#### Additional Notes
* Ensure the AWS credentials used have sufficient permissions to create S3 buckets, CloudFront distributions, and Route 53 records.
* Modify the website_files and error_page resources in the s3-bucket module to customize the website content.

 ## Setup and Usage 
 1. Clone the Repository
 2. Initialize the Project
 3. Configure Variables
 4. Plan the Deployment and apply
 
