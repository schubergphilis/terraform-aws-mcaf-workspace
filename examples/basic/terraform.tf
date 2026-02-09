terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.51.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.4"
    }
  }
}
