# Proveedor AWS
provider "aws" {
  region = var.region
}

# -----------------------------
# VPC principal
# -----------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# -----------------------------
# Subnets públicas (2, en distintas zonas)
# -----------------------------
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
  }
}

# -----------------------------
# Subnets privadas (2, en distintas zonas)
# -----------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.project_name}-private-${count.index + 1}"
  }
}

# -----------------------------
# Internet Gateway (para subnets públicas)
# -----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# -----------------------------
# Route table pública
# -----------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# -----------------------------
# Asociaciones route table pública con subnets públicas
# -----------------------------
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# -----------------------------
# IP elástica para el NAT Gateway
# -----------------------------
resource "aws_eip" "nat" {
  domain = "vpc"
}

# -----------------------------
# NAT Gateway (para permitir salida a internet desde subnets privadas)
# -----------------------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # se pone en una subnet pública
  tags = {
    Name = "${var.project_name}-nat"
  }
}

# -----------------------------
# Route table privada
# -----------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# -----------------------------
# Asociaciones route table privada con subnets privadas
# -----------------------------
resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
