resource "aws_default_tags" "teamflow" {
  tags = {
    Project = "TeamFlow"
    Owner   = "DevOps"
  }
}
