resource "shoreline_notebook" "configuration_troubleshooting_for_cassandra_snitch" {
  name       = "configuration_troubleshooting_for_cassandra_snitch"
  data       = file("${path.module}/data/configuration_troubleshooting_for_cassandra_snitch.json")
  depends_on = [shoreline_action.invoke_check_snitch_configuration]
}

resource "shoreline_file" "check_snitch_configuration" {
  name             = "check_snitch_configuration"
  input_file       = "${path.module}/data/check_snitch_configuration.sh"
  md5              = filemd5("${path.module}/data/check_snitch_configuration.sh")
  description      = "An incorrect snitch configuration due to a human error during the initial setup or changes made to the configuration file."
  destination_path = "/agent/scripts/check_snitch_configuration.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_snitch_configuration" {
  name        = "invoke_check_snitch_configuration"
  description = "An incorrect snitch configuration due to a human error during the initial setup or changes made to the configuration file."
  command     = "`chmod +x /agent/scripts/check_snitch_configuration.sh && /agent/scripts/check_snitch_configuration.sh`"
  params      = ["PATH_TO_SNITCH_CONFIG"]
  file_deps   = ["check_snitch_configuration"]
  enabled     = true
  depends_on  = [shoreline_file.check_snitch_configuration]
}

