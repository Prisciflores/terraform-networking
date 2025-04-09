# Región donde se desplegará la infraestructura
variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

# Nombre del proyecto (se usará para nombrar recursos)
variable "project_name" {
  description = "Nombre base del proyecto, usado en los tags"
  type        = string
  default     = "eks-demo"
}

# Rango de IP principal de la VPC
variable "vpc_cidr" {
  description = "CIDR block principal de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Zonas de disponibilidad (AZs) a usar
variable "azs" {
  description = "Lista de zonas de disponibilidad a usar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# CIDR blocks para subnets públicas
variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# CIDR blocks para subnets privadas
variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para subnets privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
