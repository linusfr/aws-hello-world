# ami images
# https://cloud-images.ubuntu.com/locator/ec2/
# ubuntu:22.04 on eu-central-1 -> ami-06dd92ecc74fdfb36
resource "aws_instance" "hello-world" {
  ami           =  "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.hello-world.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "hello-world"
  }
}

resource "aws_security_group" "hello-world" {
  name = "hellow-world-ec2-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}