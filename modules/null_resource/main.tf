
/*terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "3.8.0"
        }
    }
}*/

terraform {
  required_version = "1.12.1"

  required_providers {
    onepassword = {
    }
    scalr = {
      source  = "scalr/scalr"
      version = "3.16.4"
    }
  }
}
data "scalr_current_account" "data_acc" {}

data "scalr_environment" "data_env" {
#account_id = data.scalr_current_account.data_acc
  id = "env-v0pa85vqcebhnn2pb"  # optional, can only use id or name for the environment filter, if both are used there will be a conflict.
}


resource "scalr_variable" "terraform_var" {
  count = 1
  key            = "var" #-${count.index}
  value          = "TRACE"
  category       = "terraform"
  environment_id = data.scalr_environment.data_env.id
}

resource "scalr_variable" "shell_new" {
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

/*
# providers.tf

# ---------------------------------------------------------------
# 1Password provider configuration stored centrally in Scalr
# Uses the `custom` block since onepassword is not a built-in type
# ---------------------------------------------------------------
resource "scalr_provider_configuration" "onepassword" {
  name       = "onepassword"
  account_id = var.scalr_account_id

  # Share with all environments; restrict to specific env IDs if preferred
  environments = ["*"]

  # Scalr injects these arguments into the `onepassword` provider block at run time
  custom {
    provider_name = "onepassword"

    argument {
      name      = "service_account_token"
      value     = var.op_service_account_token
      sensitive = true
    }
  }
}
*/
