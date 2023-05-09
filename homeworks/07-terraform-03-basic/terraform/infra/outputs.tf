
output "amis" {
  value = data.aws_ami.ubuntu.id
}

output "Servers_web_internal_ip" {
  value = aws_instance.web[*].private_ip
}

output "Servers_external_ip" {
  value = aws_instance.web[*].public_ip
}

output "Servers_foreach_internal_ip" {
  value = [for i in aws_instance.web_foreach : i.private_ip]
}

output "Servers_foreach_external_ip" {
  value = [for i in aws_instance.web_foreach : i.public_ip]
}
