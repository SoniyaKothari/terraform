resource "aws_kms_key" "key" {
  description             = "Unique encryption key"
  deletion_window_in_days = 7
}
