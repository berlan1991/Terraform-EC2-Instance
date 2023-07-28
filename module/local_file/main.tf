#---- modules/local_file/main.tf

data "local_file" "example" {
  filename = file("./xshel-session-template")
}

