variable "overall_budget_cost_alert_enabled" {
  description = "Enable/Disable the overall budget cost alert."
  type = bool
  default = false
}

variable "service_budget_cost_alert_enabled" {
  description = "Enable/Disable a specific service budget cost alert."
  type = bool
  default = false
}

variable "budget_limit_amount" {
  description = "The amount for the budget alert."
  type = string
  default = "100"
}

variable "budget_limit_unit" {
  description = "The currency used for the budget, such as USD or GB."
  type = string
  default = "USD"
}

variable "budget_time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend, Valid values: MONTHLY, QUARTERLY, ANNUALLY."
  type = string
  default = "MONTHLY"
}

variable "budget_service_filter" {
  description = "An AWS Service filter to use when creating a specific service budget alert."
  type = string
  default = "Amazon Elastic Compute Cloud - Compute"

  validation {
    condition = (
      can(regex("^Amazon Elastic Compute Cloud - Compute", var.budget_service_filter)) ||
      can(regex("^Amazon Redshift", var.budget_service_filter)) ||
      can(regex("^Amazon Relational Database Service", var.budget_service_filter)) ||
      can(regex("^Amazon ElastiCache", var.budget_service_filter)) ||
      can(regex("^Amazon Elasticsearch Service", var.budget_service_filter))
    )
    error_message = "The Servive Filter must be one of the allowed CostFilters `Amazon Elastic Compute Cloud - Compute | Amazon Redshift | Amazon Relational Database Service | Amazon ElastiCache | Amazon Elasticsearch Service`."
  }
}

# this is not a valid input, this map object is created to generate a shortname for the budget alert rather
# than using the long name for the service.
variable "service_types" {
  type = map(string)

  default = {
    "Amazon Elastic Compute Cloud - Compute" = "ec2"
    "Amazon Redshift" = "redshift"
    "Amazon Relational Database Service" = "rds"
    "Amazon ElastiCache" = "elasticache"
    "Amazon Elasticsearch Service" = "elasticsearch"
  }
}

variable "notification_threshold" {
  description = "Threshold when the notification should be sent"
  type = string
  default = 100
}

variable "notification_type" {
  description = "What kind of budget value to notify on. Can be ACTUAL or FORECASTED"
  type = string
  default = "FORECASTED"
}

variable "notification_emails" {
  description = "List of email addresses to send budget notifications too"
  type    = string
  default = ""
}

variable "cost_type_include_credit" {
  description = "A boolean value whether to include credits in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_discount" {
  description = "Specifies whether a budget includes discounts."
  type        = string
  default     = "true"
}

variable "cost_type_include_other_subscription" {
  description = "A boolean value whether to include other subscription costs in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_recurring" {
  description = "A boolean value whether to include recurring costs in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_refund" {
  description = "A boolean value whether to include refunds in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_subscription" {
  description = "A boolean value whether to include subscriptions in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_support" {
  description = "A boolean value whether to include support costs in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_tax" {
  description = "A boolean value whether to include support costs in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_include_upfront" {
  description = "A boolean value whether to include support costs in the cost budget."
  type        = string
  default     = "true"
}

variable "cost_type_use_amortized" {
  description = "Specifies whether a budget uses the amortized rate."
  type        = string
  default     = "false"
}

variable "cost_type_use_blended" {
  description = "A boolean value whether to use blended costs in the cost budget."
  type        = string
  default     = "false"
}
