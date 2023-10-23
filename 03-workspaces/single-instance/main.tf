resource "aws_instance" "example" {
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = (
    terraform.workspace == "default" ? "t2.medium" : "t2.micro"
  )
}
