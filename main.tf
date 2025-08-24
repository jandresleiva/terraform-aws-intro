module "site_prod" {
  source       = "./modules/static_site"
  bucket_name  = "my-prod-bucket"
  index_file  = abspath("${path.root}/index.html")
}