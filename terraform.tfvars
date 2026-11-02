# aws_region formula: <region>-<availability_zone>, <region>-<availability_zone>-a, <region>-<availability_zone>-b, <region>-<availability_zone>-c
aws_region = ["us-east-2", "us-east-2-a", "us-west-2-b", "us-west-2-c"] #región de AWS donde se crearán los recursos

aws_profile = "terraform-lab" #perfil de AWS IAM que se usará para autenticar

ssh_cidr = "190.24.99.214/32" #IP pública del pc en formato CIDR

instance_type = "t3.micro" #tipo de instancia EC2 que se creará

instance_name = "learn-terraform" #nombre que tendrá la instancia EC2 en la consola de AWS