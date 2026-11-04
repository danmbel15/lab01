provider "aws" {
  region  = var.aws_region[0] #región de AWS donde se crearán los recursos
  profile = var.aws_profile   #perfil de AWS IAM que se usará para autenticar
}

data "aws_ami" "ubuntu" { #AMI es[] la imagen de máquina virtual que se usará para crear la instancia EC2
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical // La gente de Ubuntu
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type               #tipo de instancia EC2 que se creará (t3.micro, t2.micro, etc.)
  key_name      = aws_key_pair.terraform.key_name #nombre de la llave SSH que se usará para conectarse a la instancia

  vpc_security_group_ids      = [aws_security_group.terraform_lab.id] #asignar el firewall creado a la instancia
  subnet_id                   = module.vpc.public_subnets[0]          #asignar la subred pública creada a la instancia
  associate_public_ip_address = true                                  #asignar una IP pública a la instancia para poder conectarse a ella desde Internet
  tags = {
    Name = var.instance_name #nombre que tendrá la instancia EC2 en la consola de AWS
  }
}

resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"                  #nombre de la llave SSH que se creará en AWS
  public_key = file("~/.ssh/terraform-lab.pub") #ruta al archivo de la llave pública que se usará para crear la llave SSH en AWS
}

module "vpc" { #crear VPC con subredes públicas y privadas
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  name = "terraform-lab-vpc"
  cidr = "10.0.0.0/16" #definir el rango de direcciones IP privadas que se usarán en la VPC

  azs             = [var.aws_region[1], var.aws_region[2], var.aws_region[3]] #azs = Availability Zones, zonas de disponibilidad de AWS donde se crearán las subredes
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_dns_hostnames = true
}

#Crear firewall para el recurso
resource "aws_security_group" "terraform_lab" {
  name        = "terraform_lab"
  description = "Allow SSH from home"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "terraform_lab"
  }
}

#Permitir tráfico SSH desde la IP del pc
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.terraform_lab.id
  from_port         = 22 #ssh default ports
  to_port           = 22 #ssh default ports
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ssh_cidr #variable que contiene la IP pública del pc en formato CIDR
  description       = "Allow SSH from home"
}

#Permitir tráfico de salida
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.terraform_lab.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}