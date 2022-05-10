
module "prod_env" {
  source   = "../modules/team"
  cluster_name = "prod"
  team_name = local.team_name
  team_clusters  = {
    test = local.test
  }
}
