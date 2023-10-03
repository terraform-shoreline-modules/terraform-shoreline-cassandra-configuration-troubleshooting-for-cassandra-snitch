terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "configuration_troubleshooting_for_cassandra_snitch" {
  source    = "./modules/configuration_troubleshooting_for_cassandra_snitch"

  providers = {
    shoreline = shoreline
  }
}