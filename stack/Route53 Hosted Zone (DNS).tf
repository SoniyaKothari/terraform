resource "aws_route53_zone" "dns" {
  name = "example-${random_id.suffix.hex}.com"
}
