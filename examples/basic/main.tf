provider "aws" {
  region = "eu-west-1"
}

module "workspace-example" {
  source = "../.."

  name                   = "example"
  oauth_token_id         = "ot-xxxxxxxxxxxxxxxx"
  terraform_organization = "example-org"
}
