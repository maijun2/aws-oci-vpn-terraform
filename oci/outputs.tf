output "drg_id" {
  description = "作成された DRG OCID"
  value       = oci_core_drg.drg.id
}

output "cpe_id" {
  description = "作成された CPE OCID"
  value       = oci_core_cpe.cpe.id
}

output "ipsec_connection_id" {
  description = "作成された IPSec 接続 OCID"
  value       = oci_core_ipsec.ipsec.id
}

# ■ VPN トンネルの設定情報を取得
data "oci_core_ipsec_config" "config" {
  # 既に作成済みの oci_core_ipsec.ipsec リソースを指定
  ipsec_id = oci_core_ipsec.ipsec.id
}

# ■ OCI 側 VPN ヘッドエンドのグローバル IP を出力
output "oci_vpn_public_ip" {
  description = "OCI 側 VPN ヘッドエンドのパブリック IP アドレス"
  # tunnels リストの最初の要素の ip_address を参照
  value       = data.oci_core_ipsec_config.config.tunnels[0].ip_address
}