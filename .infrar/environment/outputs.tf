# The connection facts of each declared resource, as its interface defines them. Sensitive:
# they carry credentials when the module mints any. Infrar reads them per consumer.

output "db" {
  value     = module.db
  sensitive = true
}
