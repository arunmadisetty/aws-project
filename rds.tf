resource "aws_db_subnet_group" "aws-project" {
  name       = "aws-project-subnet-group"
  subnet_ids = [
    aws_subnet.private_sub.id,
    aws_subnet.private_sub2.id,
    aws_subnet.private_sub3.id
  ]

  tags = {
    Name = "aws-project-subnet-group"
  }
}

resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "Allow MySQL access from ASG instances"

  vpc_id = aws_vpc.terraform.id

  ingress {
    description = "Database"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"] 
    security_groups = [aws_security_group.terramino_instance.id]
  }

  egress {
    description = "Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_rds_cluster" "aws-project" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.11.5"
#   availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "must_be_eight_characters"
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.aws-project.name
  backup_retention_period = 5
  skip_final_snapshot       = true
  apply_immediately = true 
}

resource "aws_rds_cluster_instance" "cluster_writer" {
  identifier = "cluster-writer"
  cluster_identifier = aws_rds_cluster.aws-project.id
  instance_class    = "db.t3.small"  
  engine            = aws_rds_cluster.aws-project.engine
  engine_version = aws_rds_cluster.aws-project.engine_version
  db_subnet_group_name   = aws_db_subnet_group.aws-project.name
  publicly_accessible = true
  tags = {
    Name = "cluster-writer"
  }
}

resource "aws_rds_cluster_instance" "aws-project-reader1" {
  identifier = "aws-project-reader1"
  cluster_identifier = aws_rds_cluster.aws-project.id
  instance_class    = "db.t3.small"  
  engine            = aws_rds_cluster.aws-project.engine
  engine_version = aws_rds_cluster.aws-project.engine_version
  db_subnet_group_name   = aws_db_subnet_group.aws-project.name
  publicly_accessible = true
  tags = {
    Name = "aws-project-reader1"
  }
}

resource "aws_rds_cluster_instance" "aws-project-reader2" {
  identifier = "aws-project-reader2"
  cluster_identifier = aws_rds_cluster.aws-project.id
  instance_class    = "db.t3.small"  
  engine            = aws_rds_cluster.aws-project.engine
  engine_version = aws_rds_cluster.aws-project.engine_version
  db_subnet_group_name   = aws_db_subnet_group.aws-project.name
  publicly_accessible = true
  tags = {
    Name = "aws-project-reader2"
  }
}

resource "aws_rds_cluster_instance" "aws-project-reader3" {
  identifier = "aws-project-reader3"
  cluster_identifier = aws_rds_cluster.aws-project.id
  instance_class    = "db.t3.small"  
  engine            = aws_rds_cluster.aws-project.engine
  engine_version = aws_rds_cluster.aws-project.engine_version
  db_subnet_group_name   = aws_db_subnet_group.aws-project.name
  publicly_accessible = true
  tags = {
    Name = "aws-project-reader3"
  }
}

