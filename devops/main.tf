// https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules

module "dns" {
  source   = "../modules/team"

  team_name   = "devops"
  team_clusters  = {
    nbg4 = {
      test = {
        labels = {}
        annotations = {}
      },
      test-2 = {
        labels = {}
        annotations = {}
      }
    },
    nbg2 = {
      test = {
        labels = {}
        annotations = {}
      },
      test-2 = {
        labels = {}
        annotations = {}
      }
    },
  }
}
