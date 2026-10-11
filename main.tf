resource "okta_campaign" "campaigns" {
  for_each = var.campaigns

  name             = each.value.name
  campaign_tier    = each.value.campaign_tier
  campaign_type    = each.value.campaign_type
  description      = each.value.description
  skip_remediation = each.value.skip_remediation

  dynamic "notification_settings" {
    for_each = each.value.notification_settings != null ? each.value.notification_settings : []
    content {
      notify_review_period_end                         = notification_settings.value.notify_review_period_end
      notify_reviewer_at_campaign_end                  = notification_settings.value.notify_reviewer_at_campaign_end
      notify_reviewer_during_midpoint_of_review        = notification_settings.value.notify_reviewer_during_midpoint_of_review
      notify_reviewer_when_overdue                     = notification_settings.value.notify_reviewer_when_overdue
      notify_reviewer_when_review_assigned             = notification_settings.value.notify_reviewer_when_review_assigned
      reminders_reviewer_before_campaign_close_in_secs = notification_settings.value.reminders_reviewer_before_campaign_close_in_secs
    }
  }

  dynamic "principal_scope_settings" {
    for_each = each.value.principal_scope_settings != null ? each.value.principal_scope_settings : []
    content {
      excluded_user_ids                     = principal_scope_settings.value.excluded_user_ids
      group_ids                             = principal_scope_settings.value.group_ids
      include_only_active_users             = principal_scope_settings.value.include_only_active_users
      only_include_users_with_sod_conflicts = principal_scope_settings.value.only_include_users_with_sod_conflicts
      dynamic "predefined_inactive_users_scope" {
        for_each = principal_scope_settings.value.predefined_inactive_users_scope != null ? principal_scope_settings.value.predefined_inactive_users_scope : []
        content {
          inactive_days = predefined_inactive_users_scope.value.inactive_days
        }
      }
      type                  = principal_scope_settings.value.type
      user_ids              = principal_scope_settings.value.user_ids
      user_scope_expression = principal_scope_settings.value.user_scope_expression
    }
  }

  dynamic "remediation_settings" {
    for_each = each.value.remediation_settings != null ? each.value.remediation_settings : []
    content {
      access_approved = remediation_settings.value.access_approved
      access_revoked  = remediation_settings.value.access_revoked
      dynamic "auto_remediation_settings" {
        for_each = remediation_settings.value.auto_remediation_settings != null ? remediation_settings.value.auto_remediation_settings : []
        content {
          include_all_indirect_assignments = auto_remediation_settings.value.include_all_indirect_assignments
          dynamic "include_only" {
            for_each = auto_remediation_settings.value.include_only != null ? auto_remediation_settings.value.include_only : []
            content {
              resource_id   = include_only.value.resource_id
              resource_type = include_only.value.resource_type
            }
          }
        }
      }
      no_response = remediation_settings.value.no_response
    }
  }

  dynamic "resource_settings" {
    for_each = each.value.resource_settings != null ? each.value.resource_settings : []
    content {
      dynamic "excluded_resources" {
        for_each = resource_settings.value.excluded_resources != null ? resource_settings.value.excluded_resources : []
        content {
          resource_id   = excluded_resources.value.resource_id
          resource_type = excluded_resources.value.resource_type
        }
      }
      include_admin_roles                     = resource_settings.value.include_admin_roles
      include_entitlements                    = resource_settings.value.include_entitlements
      individually_assigned_apps_only         = resource_settings.value.individually_assigned_apps_only
      individually_assigned_groups_only       = resource_settings.value.individually_assigned_groups_only
      only_include_out_of_policy_entitlements = resource_settings.value.only_include_out_of_policy_entitlements
      dynamic "target_resources" {
        for_each = resource_settings.value.target_resources != null ? resource_settings.value.target_resources : []
        content {
          dynamic "entitlement_bundles" {
            for_each = target_resources.value.entitlement_bundles != null ? target_resources.value.entitlement_bundles : []
            content {
              id = entitlement_bundles.value.id
            }
          }
          dynamic "entitlements" {
            for_each = target_resources.value.entitlements != null ? target_resources.value.entitlements : []
            content {
              id                 = entitlements.value.id
              include_all_values = entitlements.value.include_all_values
              dynamic "values" {
                for_each = entitlements.value.values != null ? entitlements.value.values : []
                content {
                  id = values.value.id
                }
              }
            }
          }
          include_all_entitlements_and_bundles = target_resources.value.include_all_entitlements_and_bundles
          resource_id                          = target_resources.value.resource_id
          resource_type                        = target_resources.value.resource_type
        }
      }
      type = resource_settings.value.type
    }
  }

  dynamic "reviewer_settings" {
    for_each = each.value.reviewer_settings != null ? each.value.reviewer_settings : []
    content {
      bulk_decision_disabled = reviewer_settings.value.bulk_decision_disabled
      fallback_reviewer_id   = reviewer_settings.value.fallback_reviewer_id
      justification_required = reviewer_settings.value.justification_required
      reassignment_disabled  = reviewer_settings.value.reassignment_disabled
      reviewer_group_id      = reviewer_settings.value.reviewer_group_id
      reviewer_id            = reviewer_settings.value.reviewer_id
      dynamic "reviewer_levels" {
        for_each = reviewer_settings.value.reviewer_levels != null ? reviewer_settings.value.reviewer_levels : []
        content {
          fallback_reviewer_id      = reviewer_levels.value.fallback_reviewer_id
          reviewer_group_id         = reviewer_levels.value.reviewer_group_id
          reviewer_id               = reviewer_levels.value.reviewer_id
          reviewer_scope_expression = reviewer_levels.value.reviewer_scope_expression
          self_review_disabled      = reviewer_levels.value.self_review_disabled
          dynamic "start_review" {
            for_each = reviewer_levels.value.start_review != null ? reviewer_levels.value.start_review : []
            content {
              on_day = start_review.value.on_day
              when   = start_review.value.when
            }
          }
          type = reviewer_levels.value.type
        }
      }
      reviewer_scope_expression = reviewer_settings.value.reviewer_scope_expression
      self_review_disabled      = reviewer_settings.value.self_review_disabled
      type                      = reviewer_settings.value.type
    }
  }

  dynamic "schedule_settings" {
    for_each = each.value.schedule_settings != null ? each.value.schedule_settings : []
    content {
      duration_in_days = schedule_settings.value.duration_in_days
      end_date         = schedule_settings.value.end_date
      dynamic "recurrence" {
        for_each = schedule_settings.value.recurrence != null ? schedule_settings.value.recurrence : []
        content {
          ends           = recurrence.value.ends
          interval       = recurrence.value.interval
          repeat_on_type = recurrence.value.repeat_on_type
        }
      }
      start_date = schedule_settings.value.start_date
      time_zone  = schedule_settings.value.time_zone
      type       = schedule_settings.value.type
    }
  }
}

