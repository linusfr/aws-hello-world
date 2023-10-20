resource "aws_security_group" "hello-world" {
  name = "hellow-world-ec2-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ami images
# https://cloud-images.ubuntu.com/locator/ec2/
# ubuntu:22.04 on eu-central-1 -> ami-06dd92ecc74fdfb36
resource "aws_launch_configuration" "hello-world" {
  image_id        = "ami-06dd92ecc74fdfb36"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.hello-world.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Required when using a launch configuration with an ASG.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "hello-world" {
  launch_configuration = aws_launch_configuration.hello-world.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "hello-world-asg"
    propagate_at_launch = true
  }
}