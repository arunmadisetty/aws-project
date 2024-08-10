data "aws_route53_zone" "main" {
  name = "blogsh.link" 
}

resource "aws_route53_record" "writer" {
  zone_id = data.aws_route53_zone.main.zone_id
  name     = "writer.blogsh.link"  
  type     = "CNAME"
  ttl      = 300
  records  = [aws_rds_cluster.aws-project.endpoint]
}

resource "aws_route53_record" "reader1" {
  zone_id = data.aws_route53_zone.main.zone_id
  name     = "reader1.blogsh.link"  
  type     = "CNAME"
  ttl      = 300
  records  = [aws_rds_cluster.aws-project.endpoint]
}

resource "aws_route53_record" "reader2" {
  zone_id = data.aws_route53_zone.main.zone_id
  name     = "reader2.blogsh.link"  
  type     = "CNAME"
  ttl      = 300
  records  = [aws_rds_cluster.aws-project.endpoint]
}

resource "aws_route53_record" "reader3" {
  zone_id = data.aws_route53_zone.main.zone_id
  name     = "reader3.blogsh.link"  
  type     = "CNAME"
  ttl      = 300
  records  = [aws_rds_cluster.aws-project.endpoint]
}

resource "aws_route53_record" "wordpress_dns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "wordpress.blogsh.link"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.terramino.dns_name]
}

