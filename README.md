# terraform-aws-budgets-alerts
Terraform module which deploys [AWS Budgets](https://aws.amazon.com/aws-cost-management/aws-budgets/) alerts to your AWS account using the Terraform AWS Provider Budgets [resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget)

## Description

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

  #access_key = "add if not .aws/credentials or env variables"
  #secret_key = "add if not .aws/credentials or env variables"
}

module "budgets-alerts" {
  source  = "sculley/budgets-alerts/aws"
  version = "1.0.2"

  overall_budget_cost_alert_enabled = true
  budget_limit_amount               = "500"
  notification_type                 = "ACTUAL"
  notification_emails               = ["sam@samculley.co.uk"]
}
```

You can add a AWS Budget alert for a specific service (from one of the allowed services) by setting the `service_budget_cost_alert_enabled` variable to `true` such as RDS like so;

```hcl
provider "aws" {
  region = "eu-west-2"

  #access_key = "fill if not .aws/credentials or env variables"
  #secret_key = "fill if not .aws/credentials or env variables"
}

module "budgets-alerts" {
  source  = "sculley/budgets-alerts/aws"
  version = "1.0.2"

  service_budget_cost_alert_enabled = true
  budget_limit_amount               = "500"
  budget_service_filter             = "Amazon Relational Database Service"
  notification_type                 = "ACTUAL"
  notification_emails               = ["sam@samculley.co.uk"]
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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.52.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.52.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.overall_budget_cost_email_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [aws_budgets_budget.service_budget_cost_email_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budget_limit_amount"></a> [budget\_limit\_amount](#input\_budget\_limit\_amount) | The amount for the budget alert. | `string` | `"100"` | no |
| <a name="input_budget_limit_unit"></a> [budget\_limit\_unit](#input\_budget\_limit\_unit) | The currency used for the budget, such as USD or GB. | `string` | `"USD"` | no |
| <a name="input_budget_service_filter"></a> [budget\_service\_filter](#input\_budget\_service\_filter) | An AWS Service filter to use when creating a specific service budget alert. | `string` | `"Amazon Elastic Compute Cloud - Compute"` | no |
| <a name="input_budget_time_unit"></a> [budget\_time\_unit](#input\_budget\_time\_unit) | The length of time until a budget resets the actual and forecasted spend, Valid values: MONTHLY, QUARTERLY, ANNUALLY. | `string` | `"MONTHLY"` | no |
| <a name="input_cost_type_include_credit"></a> [cost\_type\_include\_credit](#input\_cost\_type\_include\_credit) | A boolean value whether to include credits in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_discount"></a> [cost\_type\_include\_discount](#input\_cost\_type\_include\_discount) | Specifies whether a budget includes discounts. | `string` | `"true"` | no |
| <a name="input_cost_type_include_other_subscription"></a> [cost\_type\_include\_other\_subscription](#input\_cost\_type\_include\_other\_subscription) | A boolean value whether to include other subscription costs in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_recurring"></a> [cost\_type\_include\_recurring](#input\_cost\_type\_include\_recurring) | A boolean value whether to include recurring costs in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_refund"></a> [cost\_type\_include\_refund](#input\_cost\_type\_include\_refund) | A boolean value whether to include refunds in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_subscription"></a> [cost\_type\_include\_subscription](#input\_cost\_type\_include\_subscription) | A boolean value whether to include subscriptions in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_support"></a> [cost\_type\_include\_support](#input\_cost\_type\_include\_support) | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_tax"></a> [cost\_type\_include\_tax](#input\_cost\_type\_include\_tax) | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_include_upfront"></a> [cost\_type\_include\_upfront](#input\_cost\_type\_include\_upfront) | A boolean value whether to include support costs in the cost budget. | `string` | `"true"` | no |
| <a name="input_cost_type_use_amortized"></a> [cost\_type\_use\_amortized](#input\_cost\_type\_use\_amortized) | Specifies whether a budget uses the amortized rate. | `string` | `"false"` | no |
| <a name="input_cost_type_use_blended"></a> [cost\_type\_use\_blended](#input\_cost\_type\_use\_blended) | A boolean value whether to use blended costs in the cost budget. | `string` | `"false"` | no |
| <a name="input_notification_emails"></a> [notification\_emails](#input\_notification\_emails) | List of email addresses to send budget notifications to | `list(string)` | `[]` | no |
| <a name="input_notification_threshold"></a> [notification\_threshold](#input\_notification\_threshold) | Threshold when the notification should be sent | `string` | `100` | no |
| <a name="input_notification_type"></a> [notification\_type](#input\_notification\_type) | What kind of budget value to notify on. Can be ACTUAL or FORECASTED | `string` | `"FORECASTED"` | no |
| <a name="input_overall_budget_cost_alert_enabled"></a> [overall\_budget\_cost\_alert\_enabled](#input\_overall\_budget\_cost\_alert\_enabled) | Enable/Disable the overall budget cost alert. | `bool` | `false` | no |
| <a name="input_service_budget_cost_alert_enabled"></a> [service\_budget\_cost\_alert\_enabled](#input\_service\_budget\_cost\_alert\_enabled) | Enable/Disable a specific service budget cost alert. | `bool` | `false` | no |
| <a name="input_service_types"></a> [service\_types](#input\_service\_types) | this is not a valid input, this map object is created to generate a shortname for the budget alert rather than using the long name for the service. | `map(string)` | <pre>{<br>  "Amazon ElastiCache": "elasticache",<br>  "Amazon Elastic Compute Cloud - Compute": "ec2",<br>  "Amazon Elasticsearch Service": "elasticsearch",<br>  "Amazon Redshift": "redshift",<br>  "Amazon Relational Database Service": "rds"<br>}</pre> | no |

## Outputs

No outputs.