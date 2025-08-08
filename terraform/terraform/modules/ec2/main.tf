resource "aws_security_group" "web" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "web" {
  count           = 2
  ami             = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (actualiza según región)
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [aws_security_group.web.name]
  user_data       = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd nodejs git
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hola desde EC2 ${count.index}</h1>" > /var/www/html/index.html
              curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
              source ~/.bashrc
              nvm install 18
              npm install -g pm2
              git clone https://github.com/karmapz/terraform-web-app.git /home/ec2-user/backend
              cd /home/ec2-user/backend
              npm install
              pm2 start src/app.js
              EOF
  tags = {
    Name = "web-server-${count.index}"
  }
}
