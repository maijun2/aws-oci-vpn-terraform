output "transit_gateway_id" {
  description = "作成した Transit Gateway の ID"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "customer_gateway_id" {
  description = "作成した Customer Gateway の ID"
  value       = aws_customer_gateway.cgw.id
}

output "vpn_connection_id" {
  description = "作成した VPN Connection の ID"
  value       = aws_vpn_connection.vpn.id
}

output "vpn_tunnel1_address" {
  description = "トンネル1 の AWS 側エンドポイント IP"
  value       = aws_vpn_connection.vpn.tunnel1_address
}

output "vpn_tunnel2_address" {
  description = "トンネル2 の AWS 側エンドポイント IP"
  value       = aws_vpn_connection.vpn.tunnel2_address
}
