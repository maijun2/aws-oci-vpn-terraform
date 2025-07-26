# AWS リージョン
variable "aws_region" {
  description = "デプロイ先 AWS リージョン"
  type        = string
}

# Transit Gateway ASN（AWS 側）
variable "transit_gateway_asn" {
  description = "Transit Gateway に設定する ASN"
  type        = number
  default     = 64512
}

# 接続先（OCI 等）のグローバル IP（初回はダミー、後で再 apply で更新）
variable "customer_gateway_ip" {
  description = "Customer Gateway のパブリック IP"
  type        = string
}

# 接続先機器の BGP ASN（OCI 標準は 31898）
variable "customer_gateway_bgp_asn" {
  description = "Customer Gateway の BGP ASN"
  type        = number
  default     = 31898
}

# 事前共有キー（英数字のみ、`.`/`_` 禁止）
variable "pre_shared_key" {
  description = "IPsec トンネルの PSK"
  type        = string
}

# トンネル内 CIDR（OCI 非対応範囲を避ける）
variable "tunnel1_inside_cidr" {
  description = "Tunnel1 の内部用 CIDR"
  type        = string
  default     = "169.254.21.0/30"
}
variable "tunnel2_inside_cidr" {
  description = "Tunnel2 の内部用 CIDR"
  type        = string
  default     = "169.254.22.0/30"
}

# IKE Phase1
variable "phase1_encryption_algorithms" {
  description = "IKE フェーズ1 暗号化アルゴリズム"
  type        = list(string)
  default     = ["AES256"]
}
variable "phase1_integrity_algorithms" {
  description = "IKE フェーズ1 整合性アルゴリズム"
  type        = list(string)
  default     = ["SHA2-384"]
}
variable "phase1_dh_group_numbers" {
  description = "IKE フェーズ1 DH グループ"
  type        = list(number)
  default     = [20]
}

# IPsec Phase2
variable "phase2_encryption_algorithms" {
  description = "IPsec フェーズ2 暗号化アルゴリズム"
  type        = list(string)
  default     = ["AES256"]
}
variable "phase2_integrity_algorithms" {
  description = "IPsec フェーズ2 整合性アルゴリズム"
  type        = list(string)
  default     = ["SHA2-256"]
}
variable "phase2_dh_group_numbers" {
  description = "IPsec フェーズ2 DH グループ"
  type        = list(number)
  default     = [5]
}

# IKE バージョン
variable "ike_versions" {
  description = "IKE バージョン"
  type        = list(string)
  default     = ["ikev2"]
}

# 既存の変数定義の最後に追記

variable "customer_gateway_name" {
  description = "Customer Gateway のタグ Name"
  type        = string
  default     = "cgw-unassociated-vpn"
}

variable "vpn_connection_name" {
  description = "VPN Connection のタグ Name"
  type        = string
  default     = "vpn-unassociated"
}
