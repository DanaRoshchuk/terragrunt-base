
terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "2.1.1"
        }
    }
}
data "scalr_current_account" "data_acc" {}

data "scalr_environment" "data_env" {
#account_id = data.scalr_current_account.data_acc
  id = "env-v0onhs8jgc2sqghv3"  # optional, can only use id or name for the environment filter, if both are used there will be a conflict.
}


resource "scalr_variable" "new_var" {
  count = 1
  key            = "var" #-${count.index}
  value          = "TRACE"
  category       = "terraform"
  environment_id = data.scalr_environment.data_env.id
}

resource "scalr_variable" "var_new2" {
  key            = "key1"
  value          = "1"
  category       = "shell"
  environment_id = data.scalr_environment.data_env.id
}

#SIMPLE NULL RESOURCE CONFIGURATION
resource "null_resource" "example" {
  triggers = {
    environment = var.environment
    message     = "This is the ${var.environment} environment."
  }

  provisioner "local-exec" {
    command = "echo Hello from ${var.environment}!"
  }
}

output "ensure_env" {
  value = "Hello from ${var.environment}!"
}


