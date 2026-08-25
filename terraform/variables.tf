variable "owner" {
  description = "The github owner that the repo should live under."
  type = string
}

variable "repo_name" {
  description = "The name of the repository to create."
  type = string
  default = "deploy-test"
}

variable "repo_description" {
  description = "The description of the repository to create."
  type = string
  default = "Testing different GitHub-based deployment strategies"
}
