# this will fetch the latest ami for ubuntu
data "aws_ami" "ubuntu" {
  most_recent = true
#   i am using the owner's canonical so that the ami is official, as outsider ami can have malware 
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}
# EC2 instance setup, i will do the initial updates and upgrade and install apache server
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "Pranavissam-project-keypair" # Ensure this key exists in your console!

  # User Data for Ubuntu (Debian-based)
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Welcome to Pranavissam's - Ubuntu Web Server</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "pranavissam-Ubuntu-Server"
  }
}

# Output the Public IP so that we can simply connect
output "server_public_ip" {
  value = aws_instance.web_server.public_ip
}