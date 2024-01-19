output "public" {
  value = module.ec2_test.public_ip
}

output "private" {
  value = module.ec2_test.private_ip
}
