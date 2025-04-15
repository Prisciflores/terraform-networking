# 🌐 Terraform Networking Module - EKS Demo

Este módulo de Terraform crea la infraestructura de red básica necesaria para desplegar un clúster de Amazon EKS. Es el primer paso dentro de una arquitectura modular basada en capas.

---

## 📌 ¿Qué crea este módulo?

- 1 VPC con DNS habilitado
- 2 subnets públicas (en distintas AZs)
- 2 subnets privadas (en distintas AZs)
- 1 Internet Gateway
- 1 NAT Gateway (con Elastic IP)
- 2 Route Tables (pública y privada) con sus asociaciones

---

## 📦 Estructura de archivos

```bash
terraform-networking/
├── main.tf            # Lógica principal de infraestructura
├── variables.tf       # Definición de variables usadas
├── outputs.tf         # Salida de recursos clave (VPC, subnets)
├── terraform.tfvars   # Valores concretos para las variables
├── .gitignore         # Archivos que no se deben subir al repositorio
└── README.md          # Este archivo

```
## ⚙️ Requisitos

- Terraform >= 1.0
- AWS CLI configurado
- Credenciales con permisos para crear recursos de red en AWS

## 🚀 Cómo usar
Clona este repositorio

Ejecuta los siguientes comandos:

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

```

## 📤 Outputs
Este módulo entrega los siguientes outputs, que pueden ser utilizados por otros módulos (como el de EKS):

- vpc_id
- public_subnet_ids
- private_subnet_ids
- availability_zones

## 📎 Notas

- Este módulo no crea recursos de seguridad (como grupos de seguridad o NACLs).
- Requiere conexión a internet para que el NAT Gateway funcione correctamente.
- Idealmente se combina con otros módulos como terraform-eks, ansible-bootstrap, etc.

<!-- Triggered GitHub Actions -->
