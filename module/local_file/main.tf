#---- modules/local_file/main.tf

resource "local_file" "sessionforxshell" {
  content = data.local_file.template.content
  filename = var.file_path
}

data "local_file" "template" {
  filename = var.input_file_template
}
