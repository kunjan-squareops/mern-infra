## Load Balancer [ALB]
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "kunjan-alb"
  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [resource.aws_security_group.kunjan-sg-lb.id]

  target_groups = [
    {
      name_prefix      = "nodetf"
      backend_protocol = "HTTP"
      backend_port     = 3000
      target_type      = "instance"

      }
      ]
     
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-west-2:421320058418:certificate/60d45d2f-7fb7-4c0c-96b4-3606f28d4c82"
      target_group_index = 0
    }
  ]
  
   http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  
  tags = {
    env = "dev"
    Name = "kunjan-tg"
  }
}

## SG for ALB
resource "aws_security_group" "kunjan-sg-lb" {
  name        = "kunjan-sg-lb"
  description = "Allow TLS inbound and outbund traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "kunjan-sg-lb"
    owner = "kunjan"
    env = "dev"
    terraform = true
  }
    }
