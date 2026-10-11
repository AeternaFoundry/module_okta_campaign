output "campaigns_id" {
  description = "Map of id values across all campaigns, keyed the same as var.campaigns except keys with no id are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.id if v.id != null && length(v.id) > 0 }
}
output "campaigns_campaign_tier" {
  description = "Map of campaign_tier values across all campaigns, keyed the same as var.campaigns except keys with no campaign_tier are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.campaign_tier if v.campaign_tier != null && length(v.campaign_tier) > 0 }
}
output "campaigns_campaign_type" {
  description = "Map of campaign_type values across all campaigns, keyed the same as var.campaigns except keys with no campaign_type are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.campaign_type if v.campaign_type != null && length(v.campaign_type) > 0 }
}
output "campaigns_description" {
  description = "Map of description values across all campaigns, keyed the same as var.campaigns except keys with no description are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.description if v.description != null && length(v.description) > 0 }
}
output "campaigns_name" {
  description = "Map of name values across all campaigns, keyed the same as var.campaigns except keys with no name are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.name if v.name != null && length(v.name) > 0 }
}
output "campaigns_notification_settings" {
  description = "Map of notification_settings values across all campaigns, keyed the same as var.campaigns except keys with no notification_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.notification_settings if v.notification_settings != null && length(v.notification_settings) > 0 }
}
output "campaigns_principal_scope_settings" {
  description = "Map of principal_scope_settings values across all campaigns, keyed the same as var.campaigns except keys with no principal_scope_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.principal_scope_settings if v.principal_scope_settings != null && length(v.principal_scope_settings) > 0 }
}
output "campaigns_remediation_settings" {
  description = "Map of remediation_settings values across all campaigns, keyed the same as var.campaigns except keys with no remediation_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.remediation_settings if v.remediation_settings != null && length(v.remediation_settings) > 0 }
}
output "campaigns_resource_settings" {
  description = "Map of resource_settings values across all campaigns, keyed the same as var.campaigns except keys with no resource_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.resource_settings if v.resource_settings != null && length(v.resource_settings) > 0 }
}
output "campaigns_reviewer_settings" {
  description = "Map of reviewer_settings values across all campaigns, keyed the same as var.campaigns except keys with no reviewer_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.reviewer_settings if v.reviewer_settings != null && length(v.reviewer_settings) > 0 }
}
output "campaigns_schedule_settings" {
  description = "Map of schedule_settings values across all campaigns, keyed the same as var.campaigns except keys with no schedule_settings are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.schedule_settings if v.schedule_settings != null && length(v.schedule_settings) > 0 }
}
output "campaigns_skip_remediation" {
  description = "Map of skip_remediation values across all campaigns, keyed the same as var.campaigns except keys with no skip_remediation are omitted"
  value       = { for k, v in okta_campaign.campaigns : k => v.skip_remediation if v.skip_remediation != null }
}

