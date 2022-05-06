// https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules

# првоайдер можно объявлять наверху дефолтный
# его будут использовать все ресурсы без указания provider
# https://www.terraform.io/language/providers/configuration

# !! The version argument in provider configurations is deprecated. 
# In Terraform 0.13 and later, always declare provider version constraints in the required_providers block.

# configure GitLab CI/CD as a backend for TF state
terraform {
  backend "http" {
  }
}

module "team" {
  source   = "../modules/team"

  team_name = "devops"
  team_clusters  = {
    test = {
      test = {
        labels = {},
        annotations = {}
      },
      test-2 = {
        labels = {},
        annotations = {}
      }
    },
    # nbg2 = {
    #   test = {
    #     labels = {},
    #     annotations = {}
    #   },
    #   test-3 = {
    #     labels = {},
    #     annotations = {}
    #   }
    # },
  }
}

# and put some specific for team objects