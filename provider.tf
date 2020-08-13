provider "aws" {
  profile                 = var.profile
  shared_credentials_file = var.credFile
  region                  = var.region
}
