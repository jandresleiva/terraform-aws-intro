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
