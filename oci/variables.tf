# ─────────────────────────
# 認証／環境情報
# ─────────────────────────
variable "tenancy_ocid" {
  description = "OCI テナンシー OCID"
  type        = string
}

variable "oci_region" {
  description = "OCI リージョン (例: us-ashburn-1)"
  type        = string
}

# ─────────────────────────
# DRG/CPE 作成先
# ─────────────────────────
variable "compartment_id" {
  description = "DRG/CPE を作成するコンパートメント OCID"
  type        = string
}


# ─────────────────────────
# AWS 側エンドポイント情報
# ─────────────────────────
variable "aws_vpn_tunnel1_address" {
  description = "AWS VPN トンネル1 のエンドポイント IP"
  type        = string
}

# ─────────────────────────
# BGP 設定
# ─────────────────────────
variable "aws_transit_gateway_asn" {
  description = "AWS Transit Gateway 側 ASN"
  type        = number
  default     = 64512
}
variable "oracle_customer_bgp_asn" {
  description = "OCI 側で指定するピア ASN (AWS 側 ASN を合わせる)"
  type        = number
  default     = 64512
}

variable "static_routes" {
  description = "OCI 側 IPSec に登録する静的ルートの CIDR 一覧 (最低1つ以上)"
  type        = list(string)
}


# ─────────────────────────
# IPsec 共有キー
# ─────────────────────────
variable "pre_shared_key" {
  description = "トンネルの事前共有キー (AWS と同じもの)"
  type        = string
}

# ─────────────────────────
# IPSec 接続表示名
# ─────────────────────────
variable "ipsec_display_name" {
  description = "IPSec Connection の表示名"
  type        = string
  default     = "oci-to-aws-ipsec"
}

# ─────────────────────────
# トンネル内部インターフェイス用 IP
# ─────────────────────────
variable "tunnel1_customer_interface_ip" {
  description = "トンネル1 の AWS 側内部インターフェイス IP"
  type        = string
  default     = "169.254.21.1/30"
}

variable "tunnel1_oracle_interface_ip" {
  description = "トンネル1 の OCI 側内部インターフェイス IP"
  type        = string
  default     = "169.254.21.2/30"
}

