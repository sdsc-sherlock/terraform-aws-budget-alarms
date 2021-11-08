resource "aws_budgets_budget" "budget_account" {
  count             = var.budget_all ? 1 : 0
  budget_type       = "COST"
  limit_amount      = var.account_budget_limit
  limit_unit        = var.limit_unit
  name              = join("-", [var.account_name, lower(var.time_unit), "all-services"])
  time_period_start = var.time_period_start
  time_unit         = var.time_unit

  cost_filters = {
    LinkedAccount = join(",", var.account_ids)
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      comparison_operator        = notification.value.comparison_operator
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = notification.value.subscriber_sns_topic_arns
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
    }
  }
}

resource "aws_budgets_budget" "budget_resources" {
  for_each = var.services

  budget_type       = "COST"
  limit_amount      = each.value.budget_limit
  limit_unit        = var.limit_unit
  name              = join("-", [var.account_name, lower(each.key), lower(var.time_unit)])
  time_unit         = each.value.time_unit
  time_period_start = var.time_period_start

  cost_filters = {
    LinkedAccount = join(",", var.account_ids)
    Service       = lookup(local.aws_services, each.value.service)
  }

  dynamic "notification" {
    for_each = each.value.notifications

    content {
      comparison_operator        = notification.value.comparison_operator
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = notification.value.subscriber_sns_topic_arns
    }
  }
}
