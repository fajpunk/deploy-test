# Environments
resource "github_repository_environment" "prod_app1" {
  environment = "prod/app1"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "prod_app2" {
  environment = "prod/app2"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "prod_app3" {
  environment = "prod/app3"
  repository  = github_repository.repo.name
}

resource "github_actions_environment_variable" "prod_app1" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.prod_app1.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-prod-app1"
}

# GitHub Actions variables. We have to duplicate them for every app in a given
# env.
resource "github_actions_environment_variable" "prod_app2" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.prod_app2.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-prod-app2"
}

resource "github_actions_environment_variable" "prod_app3" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.prod_app3.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-prod-app3"
}
