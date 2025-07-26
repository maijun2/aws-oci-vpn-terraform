# 1) Dynamic Routing Gateway (DRG) を作成
resource "oci_core_drg" "drg" {
  compartment_id = var.compartment_id
  display_name   = "drg-oci-aws"
}

# 2) Customer Premises Equipment (CPE) を作成
resource "oci_core_cpe" "cpe" {
  compartment_id = var.compartment_id
  display_name   = "cpe-aws"
  ip_address     = var.aws_vpn_tunnel1_address
}

# 3) IPSec Connection を作成 (動的 BGP)
resource "oci_core_ipsec" "ipsec" {
  compartment_id = var.compartment_id
  display_name   = var.ipsec_display_name
  cpe_id         = oci_core_cpe.cpe.id
  drg_id         = oci_core_drg.drg.id
  static_routes  = var.static_routes
}

# 4) トンネル情報を取得
data "oci_core_ipsec_connection_tunnels" "tunnels" {
  ipsec_id = oci_core_ipsec.ipsec.id
}

# 5) トンネル1 の管理設定
resource "oci_core_ipsec_connection_tunnel_management" "tunnel1" {
  ipsec_id = oci_core_ipsec.ipsec.id
  tunnel_id           = data.oci_core_ipsec_connection_tunnels.tunnels.ip_sec_connection_tunnels[0].id

  routing        = "BGP"
  shared_secret  = var.pre_shared_key
  ike_version    = "V2"

  bgp_session_info {
    customer_bgp_asn      = var.aws_transit_gateway_asn
    customer_interface_ip = var.tunnel1_customer_interface_ip
    oracle_interface_ip   = var.tunnel1_oracle_interface_ip
  }
}

