variable "compute_router_nats" {
  description = <<EOT
Map of compute_router_nats, attributes below
Required:
    - name
    - router
    - source_subnetwork_ip_ranges_to_nat
Optional:
    - auto_network_tier
    - deletion_policy
    - drain_nat_ips
    - enable_dynamic_port_allocation
    - enable_endpoint_independent_mapping
    - endpoint_types
    - icmp_idle_timeout_sec
    - initial_nat_ips
    - max_ports_per_vm
    - min_ports_per_vm
    - nat_ip_allocate_option
    - nat_ips
    - project
    - region
    - source_subnetwork_ip_ranges_to_nat64
    - tcp_established_idle_timeout_sec
    - tcp_time_wait_timeout_sec
    - tcp_transitory_idle_timeout_sec
    - type
    - udp_idle_timeout_sec
    - log_config (block):
        - enable (required)
        - filter (required)
    - nat64_subnetwork (block):
        - name (required)
    - rules (block):
        - action (optional, block):
            - source_nat_active_ips (optional)
            - source_nat_active_ranges (optional)
            - source_nat_drain_ips (optional)
            - source_nat_drain_ranges (optional)
        - description (optional)
        - match (required)
        - rule_number (required)
    - subnetwork (block):
        - name (required)
        - secondary_ip_range_names (optional)
        - source_ip_ranges_to_nat (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name                                 = string
    router                               = string
    source_subnetwork_ip_ranges_to_nat   = string
    auto_network_tier                    = optional(string)
    deletion_policy                      = optional(string)
    drain_nat_ips                        = optional(set(string))
    enable_dynamic_port_allocation       = optional(bool)
    enable_endpoint_independent_mapping  = optional(bool)
    endpoint_types                       = optional(list(string))
    icmp_idle_timeout_sec                = optional(number)
    initial_nat_ips                      = optional(set(string))
    max_ports_per_vm                     = optional(number)
    min_ports_per_vm                     = optional(number)
    nat_ip_allocate_option               = optional(string)
    nat_ips                              = optional(set(string))
    project                              = optional(string)
    region                               = optional(string)
    source_subnetwork_ip_ranges_to_nat64 = optional(string)
    tcp_established_idle_timeout_sec     = optional(number)
    tcp_time_wait_timeout_sec            = optional(number)
    tcp_transitory_idle_timeout_sec      = optional(number)
    type                                 = optional(string)
    udp_idle_timeout_sec                 = optional(number)
    log_config = optional(object({
      enable = bool
      filter = string
    }))
    nat64_subnetwork = optional(list(object({
      name = string
    })))
    rules = optional(list(object({
      action = optional(object({
        source_nat_active_ips    = optional(set(string))
        source_nat_active_ranges = optional(set(string))
        source_nat_drain_ips     = optional(set(string))
        source_nat_drain_ranges  = optional(set(string))
      }))
      description = optional(string)
      match       = string
      rule_number = number
    })))
    subnetwork = optional(list(object({
      name                     = string
      secondary_ip_range_names = optional(set(string))
      source_ip_ranges_to_nat  = set(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.compute_router_nats : (
        v.rules == null || alltrue([for item in v.rules : (item.rule_number >= 0 && item.rule_number <= 65000)])
      )
    ])
    error_message = "must be between 0 and 65000"
  }
  # Note: 10 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

