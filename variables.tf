variable "campaigns" {
  description = <<EOT
Map of campaigns, attributes below
Required:
    - name
Optional:
    - campaign_tier
    - campaign_type
    - description
    - skip_remediation
    - notification_settings (block):
        - notify_review_period_end (required)
        - notify_reviewer_at_campaign_end (required)
        - notify_reviewer_during_midpoint_of_review (required)
        - notify_reviewer_when_overdue (required)
        - notify_reviewer_when_review_assigned (required)
        - reminders_reviewer_before_campaign_close_in_secs (optional)
    - principal_scope_settings (block):
        - excluded_user_ids (optional)
        - group_ids (optional)
        - include_only_active_users (optional)
        - only_include_users_with_sod_conflicts (optional)
        - predefined_inactive_users_scope (optional, block):
            - inactive_days (optional)
        - type (required)
        - user_ids (optional)
        - user_scope_expression (optional)
    - remediation_settings (block):
        - access_approved (required)
        - access_revoked (required)
        - auto_remediation_settings (optional, block):
            - include_all_indirect_assignments (optional)
            - include_only (optional, block):
                - resource_id (optional)
                - resource_type (optional)
        - no_response (required)
    - resource_settings (block):
        - excluded_resources (optional, block):
            - resource_id (optional)
            - resource_type (optional)
        - include_admin_roles (optional)
        - include_entitlements (optional)
        - individually_assigned_apps_only (optional)
        - individually_assigned_groups_only (optional)
        - only_include_out_of_policy_entitlements (optional)
        - target_resources (optional, block):
            - entitlement_bundles (optional, block):
                - id (required)
            - entitlements (optional, block):
                - id (required)
                - include_all_values (optional)
                - values (optional, block):
                    - id (required)
            - include_all_entitlements_and_bundles (optional)
            - resource_id (required)
            - resource_type (required)
        - type (required)
    - reviewer_settings (block):
        - bulk_decision_disabled (optional)
        - fallback_reviewer_id (optional)
        - justification_required (optional)
        - reassignment_disabled (optional)
        - reviewer_group_id (optional)
        - reviewer_id (optional)
        - reviewer_levels (optional, block):
            - fallback_reviewer_id (optional)
            - reviewer_group_id (optional)
            - reviewer_id (optional)
            - reviewer_scope_expression (optional)
            - self_review_disabled (optional)
            - start_review (optional, block):
                - on_day (optional)
                - when (optional)
            - type (required)
        - reviewer_scope_expression (optional)
        - self_review_disabled (optional)
        - type (required)
    - schedule_settings (block):
        - duration_in_days (required)
        - end_date (optional)
        - recurrence (optional, block):
            - ends (optional)
            - interval (required)
            - repeat_on_type (optional)
        - start_date (required)
        - time_zone (required)
        - type (required)
EOT

  type = map(object({
    name             = string
    campaign_tier    = optional(string)
    campaign_type    = optional(string)
    description      = optional(string)
    skip_remediation = optional(bool)
    notification_settings = optional(list(object({
      notify_review_period_end                         = bool
      notify_reviewer_at_campaign_end                  = bool
      notify_reviewer_during_midpoint_of_review        = bool
      notify_reviewer_when_overdue                     = bool
      notify_reviewer_when_review_assigned             = bool
      reminders_reviewer_before_campaign_close_in_secs = optional(list(number))
    })))
    principal_scope_settings = optional(list(object({
      excluded_user_ids                     = optional(list(string))
      group_ids                             = optional(list(string))
      include_only_active_users             = optional(bool)
      only_include_users_with_sod_conflicts = optional(bool)
      predefined_inactive_users_scope = optional(list(object({
        inactive_days = optional(number)
      })))
      type                  = string
      user_ids              = optional(list(string))
      user_scope_expression = optional(string)
    })))
    remediation_settings = optional(list(object({
      access_approved = string
      access_revoked  = string
      auto_remediation_settings = optional(list(object({
        include_all_indirect_assignments = optional(bool)
        include_only = optional(list(object({
          resource_id   = optional(string)
          resource_type = optional(string)
        })))
      })))
      no_response = string
    })))
    resource_settings = optional(list(object({
      excluded_resources = optional(list(object({
        resource_id   = optional(string)
        resource_type = optional(string)
      })))
      include_admin_roles                     = optional(bool)
      include_entitlements                    = optional(bool)
      individually_assigned_apps_only         = optional(bool)
      individually_assigned_groups_only       = optional(bool)
      only_include_out_of_policy_entitlements = optional(bool)
      target_resources = optional(list(object({
        entitlement_bundles = optional(list(object({
          id = string
        })))
        entitlements = optional(list(object({
          id                 = string
          include_all_values = optional(bool)
          values = optional(list(object({
            id = string
          })))
        })))
        include_all_entitlements_and_bundles = optional(bool)
        resource_id                          = string
        resource_type                        = string
      })))
      type = string
    })))
    reviewer_settings = optional(list(object({
      bulk_decision_disabled = optional(bool)
      fallback_reviewer_id   = optional(string)
      justification_required = optional(bool)
      reassignment_disabled  = optional(bool)
      reviewer_group_id      = optional(string)
      reviewer_id            = optional(string)
      reviewer_levels = optional(list(object({
        fallback_reviewer_id      = optional(string)
        reviewer_group_id         = optional(string)
        reviewer_id               = optional(string)
        reviewer_scope_expression = optional(string)
        self_review_disabled      = optional(bool)
        start_review = optional(list(object({
          on_day = optional(number)
          when   = optional(string)
        })))
        type = string
      })))
      reviewer_scope_expression = optional(string)
      self_review_disabled      = optional(bool)
      type                      = string
    })))
    schedule_settings = optional(list(object({
      duration_in_days = number
      end_date         = optional(string)
      recurrence = optional(list(object({
        ends           = optional(string)
        interval       = string
        repeat_on_type = optional(string)
      })))
      start_date = string
      time_zone  = string
      type       = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.campaign_type == null || (contains(["RESOURCE", "USER"], v.campaign_type))
      )
    ])
    error_message = "must be one of: \"RESOURCE\", \"USER\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.resource_settings == null || alltrue([for item in v.resource_settings : (contains(["APPLICATION", "APPLICATION_AND_GROUP", "GROUP"], item.type))])
      )
    ])
    error_message = "must be one of: \"APPLICATION\", \"APPLICATION_AND_GROUP\", \"GROUP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.resource_settings == null || alltrue([for item in v.resource_settings : (item.excluded_resources == null || alltrue([for item in item.excluded_resources : (item.resource_type == null || (contains(["APPLICATION", "GROUP"], item.resource_type)))]))])
      )
    ])
    error_message = "must be one of: \"APPLICATION\", \"GROUP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.resource_settings == null || alltrue([for item in v.resource_settings : (item.target_resources == null || alltrue([for item in item.target_resources : (contains(["APPLICATION", "GROUP"], item.resource_type))]))])
      )
    ])
    error_message = "must be one of: \"APPLICATION\", \"GROUP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.reviewer_settings == null || alltrue([for item in v.reviewer_settings : (contains(["GROUP", "MULTI_LEVEL", "RESOURCE_OWNER", "REVIEWER_EXPRESSION", "USER"], item.type))])
      )
    ])
    error_message = "must be one of: \"GROUP\", \"MULTI_LEVEL\", \"RESOURCE_OWNER\", \"REVIEWER_EXPRESSION\", \"USER\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.reviewer_settings == null || alltrue([for item in v.reviewer_settings : (item.reviewer_levels == null || (length(item.reviewer_levels) <= 2))])
      )
    ])
    error_message = "must have at most 2 elements"
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.reviewer_settings == null || alltrue([for item in v.reviewer_settings : (item.reviewer_levels == null || alltrue([for item in item.reviewer_levels : (contains(["GROUP", "RESOURCE_OWNER", "REVIEWER_EXPRESSION", "USER"], item.type))]))])
      )
    ])
    error_message = "must be one of: \"GROUP\", \"RESOURCE_OWNER\", \"REVIEWER_EXPRESSION\", \"USER\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.reviewer_settings == null || alltrue([for item in v.reviewer_settings : (item.reviewer_levels == null || alltrue([for item in item.reviewer_levels : (item.start_review == null || (length(item.start_review) <= 2))]))])
      )
    ])
    error_message = "must have at most 2 elements"
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.schedule_settings == null || alltrue([for item in v.schedule_settings : (contains(["ONE_OFF", "RECURRING"], item.type))])
      )
    ])
    error_message = "must be one of: \"ONE_OFF\", \"RECURRING\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.schedule_settings == null || alltrue([for item in v.schedule_settings : (item.recurrence == null || alltrue([for item in item.recurrence : (item.repeat_on_type == null || (contains(["LAST_WEEKDAY_AS_START_DATE", "SAME_DAY_AS_START_DATE", "SAME_WEEKDAY_AS_START_DATE"], item.repeat_on_type)))]))])
      )
    ])
    error_message = "must be one of: \"LAST_WEEKDAY_AS_START_DATE\", \"SAME_DAY_AS_START_DATE\", \"SAME_WEEKDAY_AS_START_DATE\""
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.principal_scope_settings == null || alltrue([for item in v.principal_scope_settings : (item.predefined_inactive_users_scope == null || alltrue([for item in item.predefined_inactive_users_scope : (item.inactive_days == null || (item.inactive_days >= 30))]))])
      )
    ])
    error_message = "must be at least 30"
  }
  validation {
    condition = alltrue([
      for k, v in var.campaigns : (
        v.principal_scope_settings == null || alltrue([for item in v.principal_scope_settings : (item.predefined_inactive_users_scope == null || alltrue([for item in item.predefined_inactive_users_scope : (item.inactive_days == null || (item.inactive_days <= 365))]))])
      )
    ])
    error_message = "must be at most 365"
  }
}

