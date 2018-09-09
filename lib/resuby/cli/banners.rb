module Resuby::CLI
  RESUBY_BANNER = <<-EOT
Create an HTML resume from a YAML file.

Usage: resuby <options> [command] [<args>]

Commands:
generate      Generate an HTML resume

Options:
  EOT

  GENERATE_BANNER = <<-EOT
Generate an HTML file that contains your resume. This will also generate the
required CSS styles for the HTML template.

Usage: resuby generate <options>

Options:
  EOT

  INIT_BANNER = <<-EOT
Creates a template for the resume data file.

Usage: resuby init <options>

Options:
  EOT
end
