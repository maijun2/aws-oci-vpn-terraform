# 1) Transit Gateway 作成（VPC アタッチなし）
resource "aws_ec2_transit_gateway" "tgw" {
  description     = "TGW for unassociated VPN"
  amazon_side_asn = var.transit_gateway_asn

  tags = {
    Name = "tgw-unassociated-vpn"
  }
}

# 2) Customer Gateway 作成
resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.customer_gateway_name
  }
}

# 3) Site-to-Site VPN 接続（Transit Gateway にのみ紐付け）
resource "aws_vpn_connection" "vpn" {
  transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
  customer_gateway_id = aws_customer_gateway.cgw.id
  type                = "ipsec.1"
  static_routes_only  = false

  # Tunnel 1
  tunnel1_inside_cidr                  = var.tunnel1_inside_cidr
  tunnel1_preshared_key                = var.pre_shared_key
  tunnel1_phase1_encryption_algorithms = var.phase1_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.phase1_integrity_algorithms
  tunnel1_phase1_dh_group_numbers      = var.phase1_dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.phase2_encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.phase2_integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.phase2_dh_group_numbers
  tunnel1_ike_versions                 = var.ike_versions

  # Tunnel 2
  tunnel2_inside_cidr                  = var.tunnel2_inside_cidr
  tunnel2_preshared_key                = var.pre_shared_key
  tunnel2_phase1_encryption_algorithms = var.phase1_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.phase1_integrity_algorithms
  tunnel2_phase1_dh_group_numbers      = var.phase1_dh_group_numbers
  tunnel2_phase2_encryption_algorithms = var.phase2_encryption_algorithms
  tunnel2_phase2_integrity_algorithms  = var.phase2_integrity_algorithms
  tunnel2_phase2_dh_group_numbers      = var.phase2_dh_group_numbers
  tunnel2_ike_versions                 = var.ike_versions

  tags = {
    Name = var.vpn_connection_name
  }
}
