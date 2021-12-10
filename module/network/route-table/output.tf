output "route_table_id" {
  value = aws_route_table.public_routing_table.*.id[0]
}

output "private_route_table_id" {
  value = aws_route_table.private_routing_table.*.id[0]
}
