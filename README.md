# Terraform AWS Static Site Infrastructure

A Terraform project that provisions AWS infrastructure for hosting a static website using S3 and CloudFront with Origin Access Control (OAC).

This is meant as an example for the article "Beginners' guide to Terraform on AWS - S3 + CloudFront + IAM example" on Medium.

## 🏗️ Architecture

This project creates:

- **S3 Bucket**: Secure storage for static website files
- **CloudFront Distribution**: Global CDN with HTTPS redirect
- **Origin Access Control (OAC)**: Secure access from CloudFront to S3
- **IAM Policies**: Proper permissions for CloudFront to access S3

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.6.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with permissions to create S3, CloudFront, and IAM resources

## 🚀 Quick Start

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd terraform-aws-intro-clean
   ```

2. **Configure AWS credentials**

   ```bash
   aws configure
   ```

3. **Set up variables**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your unique bucket name
   ```

4. **Initialize Terraform**

   ```bash
   terraform init
   ```

5. **Plan the deployment**

   ```bash
   terraform plan
   ```

6. **Apply the infrastructure**

   ```bash
   terraform apply
   ```

7. **Access your website**
   After deployment, Terraform will output the CloudFront distribution URL where your site is accessible.

## 📁 Project Structure

```
├── main.tf              # Main configuration calling the static_site module
├── variables.tf         # Input variables
├── versions.tf          # Terraform and provider version constraints
├── providers.tf         # AWS provider configuration
├── modules/
│   └── static_site/     # Reusable module for static site infrastructure
│       ├── s3.tf        # S3 bucket configuration
│       ├── cloudfront.tf # CloudFront distribution setup
│       ├── iam.tf       # IAM policies for OAC
│       ├── uploads.tf   # File upload configuration
│       ├── variables.tf # Module input variables
│       ├── outputs.tf   # Module outputs
│       └── locals.tf    # Local values and tags
└── index.html           # Sample static website content
```

## ⚙️ Configuration

### Variables

| Variable     | Description                  | Type     | Default     | Required |
| ------------ | ---------------------------- | -------- | ----------- | -------- |
| `aws_region` | AWS region for all resources | `string` | `us-east-1` | No       |
| `bucket_name` | Globally unique S3 bucket name | `string` | None | **Yes** |

### Module Configuration

The `static_site` module accepts:

- `bucket_name`: Name for the S3 bucket (must be globally unique)
- `index_file`: Path to the index.html file

## 🔧 Customization

### Adding Your Own Content

1. Replace the content in `index.html` with your static website files
2. Update the `index_file` path in `main.tf` if needed
3. Run `terraform apply` to upload the new content

### Multiple Environments

To deploy multiple environments (staging, production), create separate configurations:

```hcl
module "site_staging" {
  source      = "./modules/static_site"
  bucket_name = "my-staging-bucket"
  index_file  = "./staging/index.html"
}

module "site_prod" {
  source      = "./modules/static_site"
  bucket_name = "my-prod-bucket"
  index_file  = "./prod/index.html"
}
```

## 🛡️ Security Features

- **Private S3 Bucket**: All public access is blocked
- **Origin Access Control (OAC)**: Modern replacement for Origin Access Identity
- **HTTPS Enforcement**: CloudFront redirects HTTP to HTTPS
- **Proper IAM Policies**: Least privilege access for CloudFront

## 📊 Outputs

After successful deployment, you'll receive:

- CloudFront distribution URL
- S3 bucket name
- CloudFront distribution ID

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

⚠️ **Warning**: This will permanently delete all resources including the S3 bucket and its contents.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

## 🐛 Troubleshooting

### Common Issues

**CloudFront deployment takes time**: CloudFront distributions can take 15-20 minutes to fully deploy and propagate globally.

**S3 bucket name conflicts**: S3 bucket names must be globally unique. If you get a naming conflict, change the `bucket_name` in `main.tf`.

**Access denied errors**: Ensure your AWS credentials have the necessary permissions for S3, CloudFront, and IAM operations.
