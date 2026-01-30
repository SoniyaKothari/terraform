resource "aws_budgets_budget" "cost" {
  name         = "tf-budget-${random_id.suffix.hex}"
  budget_type  = "COST"
  limit_amount = "10"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}
