output "migrater_command_stdout" {
  value = module.shell_cmd_workflow_template_migrator.stdout
}

output "migrater_command_stderr" {
  value = module.shell_cmd_workflow_template_migrator.stderr
}

output "migrater_command_exitstatus" {
  value = module.shell_cmd_workflow_template_migrator.exitstatus
}
