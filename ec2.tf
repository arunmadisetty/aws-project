resource "aws_launch_template" "aws-project" {
  name_prefix   = "aws-project-"
  image_id      = "ami-05c3dc660cb6907f0"  # Replace with your desired AMI ID
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "aws-project-instance"
    }
  }
}

resource "aws_autoscaling_group" "aws-project" {
  desired_capacity     = 1
  max_size             = 99
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.terraform.id, aws_subnet.terraform1.id, aws_subnet.terraform2.id]  # Replace with your subnet ID
  launch_template {
    id      = aws_launch_template.aws-project.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "aws-project-asg"
    propagate_at_launch = true
  }
}
