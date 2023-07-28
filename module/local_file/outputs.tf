#---- modules/local_file/outputs.tf
output "file_base64" {
  value = data.local_file.example.content_base64
}