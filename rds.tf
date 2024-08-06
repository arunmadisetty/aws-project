resource "aws_db_subnet_group" "example" {
  name       = "example-subnet-group"
  subnet_ids = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]  # Replace with your subnet IDs

  tags = {
    Name = "example-subnet-group"
  }
}

resource "aws_security_group" "example" {
  name        = "example-rds-sg"
  description = "Allow traffic to RDS instances"
  vpc_id      = "vpc-0123456789abcdef0"  # Replace with your VPC ID

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
    Name = "example-rds-sg"
  }
}

resource "aws_rds_cluster" "example" {
  cluster_identifier      = "example-cluster"
  engine                  = "aurora"  # Replace with your desired engine (e.g., aurora-mysql, aurora-postgresql)
  master_username         = "admin"
  master_password         = "password"  # Replace with your desired password
  database_name           = "exampledb"
  db_subnet_group_name    = aws_db_subnet_group.example.name
  vpc_security_group_ids  = [aws_security_group.example.id]

  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"

  tags = {
    Name = "example-cluster"
  }
}

resource "aws_rds_cluster_instance" "example_instance1" {
  identifier              = "example-instance-1"
  cluster_identifier      = aws_rds_cluster.example.id
  instance_class          = "db.r5.large"  # Replace with your desired instance class
  engine                  = aws_rds_cluster.example.engine
  engine_version          = "5.7.mysql_aurora.2.07.1"  # Replace with your desired engine version
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.example.name

  tags = {
    Name = "example-instance-1"
  }
}

resource "aws_rds_cluster_instance" "example_instance2" {
  identifier              = "example-instance-2"
  cluster_identifier      = aws_rds_cluster.example.id
  instance_class          = "db.r5.large"  # Replace with your desired instance class
  engine                  = aws_rds_cluster.example.engine
  engine_version          = "5.7.mysql_aurora.2.07.1"  # Replace with your desired engine version
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.example.name

  tags = {
    Name = "example-instance-2"
  }
}
