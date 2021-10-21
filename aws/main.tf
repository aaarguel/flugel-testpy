provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] #099720109477
}

resource "aws_instance" "flugel-ec2" {
  ami           = data.aws_ami.ubuntu.id  
  instance_type = "t3.micro"  
  key_name= "aws_chocotienda"
  user_data = file("./install.sh")
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = var.tags
}

resource "aws_s3_bucket" "flugels3ec" {
  bucket = "flugel-bucket-ec"
  acl    = "public-read"
  versioning {
    enabled = true
  }
  tags = var.tags
}


resource "aws_security_group" "web-sg" {
  name = "flugel-sg"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}