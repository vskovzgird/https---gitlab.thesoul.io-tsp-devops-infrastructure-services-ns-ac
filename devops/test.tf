
module "test_env" {
  source   = "../modules/team"
  cluster_name = "test"
  team_name = local.team_name
  team_clusters  = {
    test = local.test
  }
}
