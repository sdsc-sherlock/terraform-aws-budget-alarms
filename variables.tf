variable "account_name" {
  description = "Specifies the name of the AWS account"
  type        = string
  default     = ""
}
variable "account_ids" {
  description = "List of accounts ids for budget scope"
  type        = list(string)
  default     = []
}
variable "account_budget_limit" {
  description = "Set the budget limit for the AWS account."
  type        = string
}
variable "budget_all" {
  type        = bool
  description = "Whether to create budget for all services in listed account ids."
  default     = true
}
variable "create_slack_integration" {
  type        = bool
  description = "Whether to create the Slack integration through AWS Chatbot or not."
  default     = true
}
variable "limit_unit" {
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold."
  type        = string
  default     = "USD"
}
variable "notifications" {
  description = "Can be used multiple times to configure budget notification thresholds."
  type = map(object({
    comparison_operator        = string
    subscriber_email_addresses = list(string)
    subscriber_sns_topic_arns  = list(string)
    threshold                  = number
    threshold_type             = string
    notification_type          = string
  }))
}
variable "services" {
  description = "Define the list of services and their limit of budget."
  type = map(object({
    budget_limit  = string
    notifications = map(any)
    service       = string
    time_unit     = string
  }))
}
variable "slack_channel_id" {
  type        = string
  description = "The ID of the Slack channel. For example, ABCBBLZZZ. (Should be set when create_slack_integration is enabled)."
  default     = ""
}
variable "slack_workspace_id" {
  type        = string
  description = "The ID of the Slack workspace authorized with AWS Chatbot. (Should be set when create_slack_integration is enabled)."
  default     = ""
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags."
}
variable "time_period_start" {
  description = "The time to start a budget values: `Year-Month-Day_Hour:Minute`."
  type        = string
  default     = "2020-01-01_00:00"
}
variable "time_unit" {
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: `MONTHLY`, `QUARTERLY`, `ANNUALLY`."
  type        = string
  default     = "MONTHLY"
}
