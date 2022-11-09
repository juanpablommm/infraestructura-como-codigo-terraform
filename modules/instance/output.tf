output "instance_ip" {
  value = aws_instance.terraform-platzi-instance.*.public_ip
}