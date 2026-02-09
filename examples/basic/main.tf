provider "aws" {
  region = "eu-west-1"
}

# If you are using this module in combination with `terraform-aws-mcaf-avm` the OIDC provider is already created. 
data "tls_certificate" "oidc_certificate" {
  url = "https://app.terraform.io"
}

resource "aws_iam_openid_connect_provider" "tfc_provider" {
  url             = data.tls_certificate.oidc_certificate.url
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = [data.tls_certificate.oidc_certificate.certificates[0].sha1_fingerprint]
}

module "workspace-example" {
  source = "../.."

  name                   = "example"
  oauth_token_id         = "ot-xxxxxxxxxxxxxxxx"
  terraform_organization = "example-org"

  oidc_settings = {
    provider_arn = aws_iam_openid_connect_provider.tfc_provider.arn
  }
}
