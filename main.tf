# resource "aws_lb_target_group" "hashicups" {
#   name     = "learn-asg-hashicups"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.terraform.id
# }



data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_launch_configuration" "terramino" {
  name_prefix     = "learn-terraform-aws-asg-"
  image_id        = data.aws_ami.amazon-linux.id
  instance_type   = "t2.micro"
  user_data       = base64encode(file("user-data.sh"))
security_groups = [aws_security_group.terramino_instance.id]
  lifecycle {
    create_before_destroy = true
  }
}

# data "template_file" "init" {
#   template = "${file("user-data.sh")}"
#   vars = {
#     bucket_name = "${aws_s3_bucket.terraformshokhinur.id}"
#     db_name = var.db_name
#     db_user = var.db_user
#     db_password = var.db_password
#     db_endpoint = local.new_endpoint
#   }
# }


resource "aws_autoscaling_group" "terramino" {
  min_size             = 1
  max_size             = 99
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.terramino.name
  vpc_zone_identifier  = [
    aws_subnet.terraform.id,
    aws_subnet.terraform1.id,
    aws_subnet.terraform2.id
  ]
}

resource "aws_lb" "terramino" {
  name               = "learn-asg-terramino-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terramino_lb.id]
  subnets            = [
    aws_subnet.terraform.id,
    aws_subnet.terraform1.id,
    aws_subnet.terraform2.id
  ]
}

resource "aws_lb_listener" "terramino" {
  load_balancer_arn = aws_lb.terramino.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terramino.arn
  }
  
}

 resource "aws_lb_target_group" "terramino" {
   name     = "learn-asg-terramino"
   port     = 80
   protocol = "HTTP"
   vpc_id   = aws_vpc.terraform.id
 }

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.terramino.id
  lb_target_group_arn = aws_lb_target_group.terramino.arn
}

resource "aws_security_group" "terramino_instance" {
  name = "learn-asg-terramino-instance"
  ingress {
    description = "Http"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [aws_security_group.terramino_lb.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Https"
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    security_groups = [aws_security_group.terramino_lb.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Ssh"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    description = "Outbound"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#   egress {
#     from_port       = 3306
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.rds_security_group.id]
#   }

  vpc_id = aws_vpc.terraform.id
}

resource "aws_security_group" "terramino_lb" {
  name = "learn-asg-terramino-lb_sg"
  description = "Allow http and https"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.terraform.id
}

