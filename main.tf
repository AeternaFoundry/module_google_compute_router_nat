resource "google_compute_router_nat" "compute_router_nats" {
  for_each = var.compute_router_nats

  name                                 = each.value.name
  router                               = each.value.router
  source_subnetwork_ip_ranges_to_nat   = each.value.source_subnetwork_ip_ranges_to_nat
  auto_network_tier                    = each.value.auto_network_tier
  deletion_policy                      = each.value.deletion_policy
  drain_nat_ips                        = each.value.drain_nat_ips
  enable_dynamic_port_allocation       = each.value.enable_dynamic_port_allocation
  enable_endpoint_independent_mapping  = each.value.enable_endpoint_independent_mapping
  endpoint_types                       = each.value.endpoint_types
  icmp_idle_timeout_sec                = each.value.icmp_idle_timeout_sec
  initial_nat_ips                      = each.value.initial_nat_ips
  max_ports_per_vm                     = each.value.max_ports_per_vm
  min_ports_per_vm                     = each.value.min_ports_per_vm
  nat_ip_allocate_option               = each.value.nat_ip_allocate_option
  nat_ips                              = each.value.nat_ips
  project                              = each.value.project
  region                               = each.value.region
  source_subnetwork_ip_ranges_to_nat64 = each.value.source_subnetwork_ip_ranges_to_nat64
  tcp_established_idle_timeout_sec     = each.value.tcp_established_idle_timeout_sec
  tcp_time_wait_timeout_sec            = each.value.tcp_time_wait_timeout_sec
  tcp_transitory_idle_timeout_sec      = each.value.tcp_transitory_idle_timeout_sec
  type                                 = each.value.type
  udp_idle_timeout_sec                 = each.value.udp_idle_timeout_sec

  dynamic "log_config" {
    for_each = each.value.log_config != null ? [each.value.log_config] : []
    content {
      enable = log_config.value.enable
      filter = log_config.value.filter
    }
  }

  dynamic "nat64_subnetwork" {
    for_each = each.value.nat64_subnetwork != null ? each.value.nat64_subnetwork : []
    content {
      name = nat64_subnetwork.value.name
    }
  }

  dynamic "rules" {
    for_each = each.value.rules != null ? each.value.rules : []
    content {
      dynamic "action" {
        for_each = rules.value.action != null ? [rules.value.action] : []
        content {
          source_nat_active_ips    = action.value.source_nat_active_ips
          source_nat_active_ranges = action.value.source_nat_active_ranges
          source_nat_drain_ips     = action.value.source_nat_drain_ips
          source_nat_drain_ranges  = action.value.source_nat_drain_ranges
        }
      }
      description = rules.value.description
      match       = rules.value.match
      rule_number = rules.value.rule_number
    }
  }

  dynamic "subnetwork" {
    for_each = each.value.subnetwork != null ? each.value.subnetwork : []
    content {
      name                     = subnetwork.value.name
      secondary_ip_range_names = subnetwork.value.secondary_ip_range_names
      source_ip_ranges_to_nat  = subnetwork.value.source_ip_ranges_to_nat
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

