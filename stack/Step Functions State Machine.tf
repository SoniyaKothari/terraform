resource "aws_iam_role" "sfn_role" {
  name = "tf-sfn-role-${random_id.suffix.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "states.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_sfn_state_machine" "workflow" {
  name     = "tf-workflow-${random_id.suffix.hex}"
  role_arn = aws_iam_role.sfn_role.arn

  definition = jsonencode({
    StartAt = "Hello"
    States = {
      Hello = {
        Type   = "Pass"
        End    = true
        Result = "Hello Terraform"
      }
    }
  })
}
