provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "instance_1" {
  ami           = "ami-0b0a3a2350a9877be"  
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-T2-Micro"
  }
}

resource "aws_instance" "instance_2" {
  ami           = "ami-0b0a3a2350a9877be"  
  instance_type = "t2.small"

  tags = {
    Name = "Instance-T2-Small"
  }
}

