# terraform-aws-budgets-alerts
Terraform module which deploys [AWS Budgets](https://aws.amazon.com/aws-cost-management/aws-budgets/) alerts to your AWS account using the Terraform AWS Provider Budgets [resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget)

# Description

This Terraform module deploys an AWS Budget alert to send a notification if the actual or forecasted cost has reached a certain limit within a AWS account. You can specify to choose to create an alert for the overall cost of the account or from one of the allowed services;

- Amazon Elastic Compute Cloud - Compute
- Amazon Redshift
- Amazon Relational Database Service
- Amazon ElastiCache
- Amazon Elasticsearch Service

AWS Budgets use the cost visualisation provided by Cost Explorer to show you the status of your budgets, to provide forecasts of your estimated costs, and to track your AWS usage, including your free tier usage. 

## How to use

To create an overall cost alert of the AWS account we need to specify the `overall_budget_cost_alert_enabled` variable as `true` to the module, this will create an AWS Budget alert that will alert when the specified budget limit amount is reached and send an email notification to the email addresses specified.

```hcl
provider "aws" {
  region = "eu-west-2"

  #access_key = "fill if not .aws/credentials or env variables"
  #secret_key = "fill if not .aws/credentials or env variables"
}

module "aws_budgets_monthly_alert" {
  source = "github.com/sculley/terraform-aws-budgets-alerts"

  overall_budget_cost_alert_enabled = true
  budget_limit_amount               = "500"
  notification_type                 = "ACTUAL"
  notification_emails               = "sam@samculley.co.uk"
}
```

You can add a AWS Budget alert for a specific service (from one of the allowed services) by setting the `service_budget_cost_alert_enabled` variable to `true` such as RDS like so;

```hcl
provider "aws" {
  region = "eu-west-2"

  #access_key = "fill if not .aws/credentials or env variables"
  #secret_key = "fill if not .aws/credentials or env variables"
}

module "aws_budgets_monthly_alert" {
  source = "github.com/sculley/terraform-aws-budgets-alerts"

  service_budget_cost_alert_enabled = true
  budget_limit_amount               = "500"
  budget_service_filter             = "Amazon Relational Database Service
  notification_type                 = "ACTUAL"
  notification_emails               = "sam@samculley.co.uk"
}
```

Run terraform init

```shell
$ terraform init
```

Run terraform plan

```shell
$ terraform plan
```

Apply the Terraform configuration

```shell
$ terraform apply
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| overall_budget_cost_alert_enabled | Enable/Disable the overall budget cost alert | `bool` | `false` | yes |
| service_budget_cost_alert_enabled | Enable/Disable a specific service budget cost alert | `bool` | `false` | yes |
| budget_limit_amount | The amount for the budget alert. | `string` | `100` | no |
| budget_limit_unit | The currency used for the budget, such as USD or GB | `string` | `USD` | no |
| budget_time_unit | The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY | `string` | `MONTHLY` | no |
| budget_service_filter | An AWS Service to use | `string` | `Amazon Elastic Compute Cloud - Compute` | no |
| notification_threshold | % Threshold when the notification should be sent. | `string` | `100` | no |
| notification_type | What kind of budget value to notify on. Can be ACTUAL or FORECASTED | `string` | `FORECASTED` | no |
| notification_emails | List of email addresses to send budget notifications too | `string` | `""` | yes |
| cost_type_include_credit | A boolean value whether to include credits in the cost budget. | `string` | `"true"` | no |
| cost_type_include_discount | Specifies whether a budget includes discounts. | `string` | `"true"` | no |
| cost_type_include_other_subscription | A boolean value whether to include other subscription costs in the cost budget. | `string` | `"true"` | no |
| cost_type_include_recurring | A boolean value whether to include recurring costs in the cost budget. | `string` | `"true"` | no |
| cost_type_include_refund | A boolean value whether to include refunds in the cost budget. | `string` | `"true"` | no |
| cost_type_include_subscription | A boolean value whether to include subscriptions in the cost budget. | `string` | `"true"` | no |
| cost_type_include_support | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| cost_type_include_tax | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| cost_type_include_upfront | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| cost_type_use_amortized | Specifies whether a budget uses the amortized rate. | `string` | `"false"` | no |
| cost_type_use_blended | A boolean value whether to use blended costs in the cost budget. | `string` | `"false"` | no |
