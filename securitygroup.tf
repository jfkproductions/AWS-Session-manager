resource "aws_security_group" "instance" {
  name        = "instance_sg"
  description = "Security group for instance"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}