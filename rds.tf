resource "aws_db_subnet_group" "aws-project" {
  name       = "aws-project-subnet-group"
  subnet_ids = [
    aws_subnet.private_sub,
    aws_subnet.private_sub2,
    aws_subnet.private_sub3
    ]  # Replace with your subnet IDs

  tags = {
    Name = "aws-project-subnet-group"
  }
}

resource "aws_security_group" "aws-project" {
  name        = "aws-project-rds-sg"
  description = "Allow traffic to RDS instances"
#   vpc_id      = aws_vpc.vpc_id  # Replace with your VPC ID

  ingress {
    from_port   = 3306  # Replace with your desired port (e.g., 3306 for MySQL)
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with more restrictive CIDR blocks as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-project-rds-sg"
  }
}

resource "aws_rds_cluster" "aws-project" {
  cluster_identifier      = "aws-project-cluster"
  engine                  = "aurora-mysql"  # Replace with your desired engine (e.g., aurora-mysql, aurora-postgresql)
  master_username         = "admin"
  master_password         = "password"  # Replace with your desired password
  database_name           = "aws-projectdb"
  db_subnet_group_name    = aws_db_subnet_group.aws-project.name
  vpc_security_group_ids  = [aws_security_group.aws-project.id]

  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"

  tags = {
    Name = "aws-project-cluster"
  }
}

resource "aws_rds_cluster_instance" "aws-project_instance1" {
  identifier              = "aws-project-instance-1"
  cluster_identifier      = aws_rds_cluster.aws-project.id
  instance_class          = "db.r5.large"  # Replace with your desired instance class
  engine                  = aws_rds_cluster.aws-project.engine
  engine_version          = "5.7.mysql_aurora.2.07.1"  # Replace with your desired engine version
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.aws-project.name

  tags = {
    Name = "aws-project-instance-1"
  }
}

resource "aws_rds_cluster_instance" "aws-project_instance2" {
  identifier              = "aws-project-instance-2"
  cluster_identifier      = aws_rds_cluster.aws-project.id
  instance_class          = "db.r5.large"  # Replace with your desired instance class
  engine                  = aws_rds_cluster.aws-project.engine
  engine_version          = "5.7.mysql_aurora.2.07.1"  # Replace with your desired engine version
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.aws-project.name

  tags = {
    Name = "aws-project-instance-2"
  }
}
