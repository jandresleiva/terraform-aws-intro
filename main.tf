# ---------- Bucket policy: only this distribution can read ----------
data "aws_iam_policy_document" "allow_cf_read" {
  statement {
    sid = "AllowCloudFrontServicePrincipalReadOnly"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.cdn.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.allow_cf_read.json
}

# ---------- Upload index.html from local file ----------
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  source       = "${path.module}/index.html"   # file sits next to main.tf
  etag         = filemd5("${path.module}/index.html")
  content_type = "text/html; charset=utf-8"

  # Ensure policy is attached before we try to read via CloudFront
  depends_on = [aws_s3_bucket_policy.site]
}


# ---------- Outputs ----------
output "bucket_name"     { value = aws_s3_bucket.site.bucket }
output "cdn_domain"      { value = aws_cloudfront_distribution.cdn.domain_name }
output "distribution_id" { value = aws_cloudfront_distribution.cdn.id }
