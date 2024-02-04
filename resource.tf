#this the the block to create the ec2 instance
resource "aws_instance" "server" {
  ami                    = "ami-0d63de463e6604d0a"
  instance_type          = "t2.micro"
  key_name      = "terraform_key"
  vpc_security_group_ids = [aws_security_group.web_SG.id]
  subnet_id              = aws_subnet.public_subnet.id

connection {
  type        = "ssh"
  user        = "ec2-user"  # For Amazon Linux, use "ec2-user"
  private_key = file("privet.key/terraform_key.pem")   # Replace with the path to your private key
  host        = self.public_ip
}
provisioner "remote-exec" {
  inline = [
    "sudo yum update -y",
    "sudo yum install -y httpd",
    "sudo systemctl start httpd",
    "sudo systemctl enable httpd",
    "sudo chmod 777 /var/www/html/",
    "sudo touch /var/www/html/index.html",
    "sudo chmod 777 /var/www/html/index.html"

  ]
}


provisioner "file" {
    source      = "index.html"  # Replace with the path to your local file
    destination = "/var/www/html/index.html"  # Replace with the path on the remote instance
  }


}
