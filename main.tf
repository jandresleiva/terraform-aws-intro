module "site_prod" {
  source       = "./modules/static_site"
  bucket_name  = "my-prod-bucket"
  index_file = "./prod/index.html"
}