

# data "aws_ami" "amzn-linux-2023-ami" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.*-x86_64"]
#   }
# }

# resource "aws_launch_template" "template" {
#   name_prefix     = "test"
#   image_id        = data.aws_ami.amzn-linux-2023-ami.id
#   instance_type   = "t2.micro"
#   # security_groups = ["sg-12345678"]
# }

# resource "aws_autoscaling_group" "autoscale" {
#   name                  = "test-autoscaling-group"
# #   availability_zones    = ["us-east-2a"]
#   desired_capacity      = 1
#   max_size              = 99
#   min_size              = 1
#   health_check_type     = "EC2"
#   termination_policies  = ["OldestInstance"]
#   vpc_zone_identifier  = [
#     aws_subnet.terraform.id,
#     aws_subnet.terraform1.id,
#     aws_subnet.terraform2.id
#   ]

#   launch_template {
#     id      = aws_launch_template.template.id
#     version = "$Latest"
#   }
# }