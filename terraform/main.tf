terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.owner
}

resource "github_repository" "repo" {
  name        = var.repo_name
  description = var.repo_description

  visibility = "public"
}

# Rulesets
resource "github_repository_ruleset" "default" {
  name        = "default"
  repository  = github_repository.repo.name
  target      = "branch"
  enforcement = "active"

  rules {
    pull_request {}
  }

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }
}

# GitHub environments
resource "github_repository_environment" "dev" {
  environment = "dev"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "int" {
  environment = "int"
  repository  = github_repository.repo.name
}

resource "github_repository_environment" "prod" {
  environment = "prod"
  repository  = github_repository.repo.name

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

# GitHub Actions variable whose value differs among environments
resource "github_actions_environment_variable" "dev" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.dev.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-dev"
}

resource "github_actions_environment_variable" "int" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.int.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-int"
}

resource "github_actions_environment_variable" "prod" {
  repository    = github_repository.repo.name
  environment   = github_repository_environment.prod.environment
  variable_name = "SOME_SETTING"
  value         = "some-value-prod"
}
