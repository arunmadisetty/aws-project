output "vpc_id" {
  value = aws_vpc.terraform.id
}

output "public_subnet_id" {
  value = aws_subnet.terraform.id
}

output "public_subnet1_id" {
  value = aws_subnet.terraform1.id
}

output "public_subnet2_id" {
  value = aws_subnet.terraform2.id
}

output "private_subnet_id" {
  value = aws_subnet.private_sub
}

output "private_subnet1_id" {
  value = aws_subnet.private_sub2.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_sub3.id
}
