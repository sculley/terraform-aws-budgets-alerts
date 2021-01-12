# Generate a random string for the AWS Budget Alert name
resource "random_string" "random" {
  count = var.overall_budget_cost_alert_enabled || var.service_budget_cost_alert_enabled ? 1 : 0
  length = 8
  upper = true
  lower = false
  number = false
  special = false
}

# Creates a AWS Budget for the overall cost of the account
resource "aws_budgets_budget" "overall_budget_cost_email_notification" {
  name              = "${lower(var.budget_time_unit)}-budget-cost-alert-${random_string.random[count.index].result}"
  count             = var.overall_budget_cost_alert_enabled ? 1 : 0
  budget_type       = "COST"
  limit_amount      = var.budget_limit_amount
  limit_unit        = var.budget_limit_unit
  time_period_start = "2021-01-01_00:00"
  time_unit         = var.budget_time_unit

  cost_types {
    # List of available cost types: 
    # https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_CostTypes.html
    include_credit = var.cost_type_include_credit
    include_discount = var.cost_type_include_discount
    include_other_subscription = var.cost_type_include_other_subscription
    include_recurring = var.cost_type_include_recurring
    include_refund = var.cost_type_include_refund
    include_subscription = var.cost_type_include_subscription
    include_support = var.cost_type_include_support
    include_tax = var.cost_type_include_tax
    include_upfront = var.cost_type_include_upfront
    use_amortized = var.cost_type_use_amortized
    use_blended = var.cost_type_use_blended
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.notification_threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = var.notification_type
    subscriber_email_addresses = [var.notification_emails]
  }
}

# Creates a AWS Budget for the cost a specific service
resource "aws_budgets_budget" "service_budget_cost_email_notification" {
  name              = "${lookup(var.service_types, var.budget_service_filter, "service")}-${lower(var.budget_time_unit)}-budget-cost-alert-${random_string.random[count.index].result}"
  count             = var.service_budget_cost_alert_enabled ? 1 : 0
  budget_type       = "COST"
  limit_amount      = var.budget_limit_amount
  limit_unit        = var.budget_limit_unit
  time_period_start = "2021-01-01_00:00"
  time_unit         = var.budget_time_unit

  cost_types {
    # List of available cost types: 
    # https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_CostTypes.html
    include_credit = var.cost_type_include_credit
    include_discount = var.cost_type_include_discount
    include_other_subscription = var.cost_type_include_other_subscription
    include_recurring = var.cost_type_include_recurring
    include_refund = var.cost_type_include_refund
    include_subscription = var.cost_type_include_subscription
    include_support = var.cost_type_include_support
    include_tax = var.cost_type_include_tax
    include_upfront = var.cost_type_include_upfront
    use_amortized = var.cost_type_use_amortized
    use_blended = var.cost_type_use_blended
  }

  cost_filters = {
    Service =  var.budget_service_filter
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.notification_threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = var.notification_type
    subscriber_email_addresses = [var.notification_emails]
  }
}