# Environments
resource "github_repository_environment" "int_app1" {
  environment = "int/app1"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "int_app2" {
  environment = "int/app2"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "int_app3" {
  environment = "int/app3"
  repository  = github_repository.repo.name
}

resource "github_actions_environment_variable" "int_app1" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.int_app1.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-int-app1"
}

# GitHub Actions variables. We have to duplicate them for every app in a given
# env.
resource "github_actions_environment_variable" "int_app2" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.int_app2.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-int-app2"
}

resource "github_actions_environment_variable" "int_app3" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.int_app3.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-int-app3"
}
