# ID de la VPC
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

# IDs de subnets públicas
output "public_subnet_ids" {
  description = "Lista de IDs de subnets públicas"
  value       = aws_subnet.public[*].id
}

# IDs de subnets privadas
output "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas"
  value       = aws_subnet.private[*].id
}

# Zona de disponibilidad usadas
output "availability_zones" {
  description = "Lista de zonas de disponibilidad utilizadas"
  value       = var.azs
}
