# Environments
resource "github_repository_environment" "dev_app1" {
  environment = "dev/app1"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "dev_app2" {
  environment = "dev/app2"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "dev_app3" {
  environment = "dev/app3"
  repository  = github_repository.repo.name
}

resource "github_actions_environment_variable" "dev_app1" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.dev_app1.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-dev-app1"
}

# GitHub Actions variables. We have to duplicate them for every app in a given
# env.
resource "github_actions_environment_variable" "dev_app2" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.dev_app2.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-dev-app2"
}

resource "github_actions_environment_variable" "dev_app3" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.dev_app3.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-dev-app3"
}
