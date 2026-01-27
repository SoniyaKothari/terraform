resource "aws_cognito_user_pool" "users" {
  name = "tf-users-${random_id.suffix.hex}"
}
