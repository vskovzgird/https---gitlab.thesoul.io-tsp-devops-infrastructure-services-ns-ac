// https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules

# првоайдер можно объявлять наверху дефолтный
# его будут использовать все ресурсы без указания provider
# https://www.terraform.io/language/providers/configuration

# !! The version argument in provider configurations is deprecated. 
# In Terraform 0.13 and later, always declare provider version constraints in the required_providers block.

# configure GitLab CI/CD as a backend for TF state
terraform {
  backend "local" {
  }
}

locals {
  team_name = "devops"
  test = {
    test = {
        labels = {},
        annotations = {}
        },
    test-2 = {
        labels = {},
        annotations = {
            ann-1 = "ann-1"
        }
        },
        test-3 = {
        labels = {},
        annotations = {}
        }
  }
  prod = {
    ns-1 = {
        labels = {},
        annotations = {}
        },
    ns-2 = {
        labels = {},
        annotations = {
            ann-1 = "ann-1"
        }
        },
        test-3 = {
        labels = {},
        annotations = {}
        }
  }
}


# https://www.puppeteers.net/blog/terraform-resources-with-dynamic-provider-values/#:~:text=Terraform%20allows%20you%20to%20define,have%20to%20learn%20provider%20aliases. 
