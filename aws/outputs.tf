output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.flugel-ec2.id
}

output "s3_id" {
  description = "ID of the EC2 instance"
  value       = aws_s3_bucket.flugels3ec.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.flugel-ec2.public_ip
}

output "application-tags" {
  value = "${aws_instance.flugel-ec2.public_ip}:8080/tags"
}

output "application-shutdown" {
  value = "${aws_instance.flugel-ec2.public_ip}:8080/shutdown"
}