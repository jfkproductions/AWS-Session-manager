resource "aws_instance" "session_manager" {
  ami                         = "ami-0d7c6a505755631dd"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name


  tags = {
    Name = "session-manager-EC2Instance"
  }
  vpc_security_group_ids = [aws_security_group.session_manager_ec2_sg.id]
}

resource "aws_security_group" "session_manager_ec2_sg" {
  name        = "allow_access"
  description = "allow inbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the internet."
  }

  tags = {
    Name = "ssm-ec2-sg"
  }
}