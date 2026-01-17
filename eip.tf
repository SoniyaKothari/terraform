resource "aws_eip" "teamflow_eip" {
  instance = aws_instance.web_server.id
}
