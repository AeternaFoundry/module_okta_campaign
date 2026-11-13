output "campaigns_id" {
  description = "Map of id values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.id }
}
output "campaigns_campaign_tier" {
  description = "Map of campaign_tier values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.campaign_tier }
}
output "campaigns_campaign_type" {
  description = "Map of campaign_type values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.campaign_type }
}
output "campaigns_description" {
  description = "Map of description values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.description }
}
output "campaigns_name" {
  description = "Map of name values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.name }
}
output "campaigns_notification_settings" {
  description = "Map of notification_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.notification_settings }
}
output "campaigns_principal_scope_settings" {
  description = "Map of principal_scope_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.principal_scope_settings }
}
output "campaigns_remediation_settings" {
  description = "Map of remediation_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.remediation_settings }
}
output "campaigns_resource_settings" {
  description = "Map of resource_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.resource_settings }
}
output "campaigns_reviewer_settings" {
  description = "Map of reviewer_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.reviewer_settings }
}
output "campaigns_schedule_settings" {
  description = "Map of schedule_settings values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.schedule_settings }
}
output "campaigns_skip_remediation" {
  description = "Map of skip_remediation values across all campaigns, keyed the same as var.campaigns"
  value       = { for k, v in okta_campaign.campaigns : k => v.skip_remediation }
}

