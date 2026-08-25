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
  name                   = var.repo_name
  description            = var.repo_description
  visibility             = "public"
  delete_branch_on_merge = true
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
