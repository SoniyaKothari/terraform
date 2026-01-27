resource "aws_cloudwatch_event_rule" "event" {
  name        = "tf-event-${random_id.suffix.hex}"
  description = "Trigger on EC2 state change"

  event_pattern = jsonencode({
    source = ["aws.ec2"]
  })
}
