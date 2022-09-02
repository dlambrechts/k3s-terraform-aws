# Create the VPC
 resource "aws_vpc" "Main" {                # Creating VPC here
   cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
   instance_tenancy = "default"
     tags = {
    Name = "vpc-test"
  }
 }

 # Create Internet Gateway and attach it to VPC
 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
 }

 # Create a Public Subnets.
 resource "aws_subnet" "publicsubnets" {    # Creating Public Subnets
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.public_subnets}"        # CIDR block of public subnets
   map_public_ip_on_launch = true
 }

 #Create a Private Subnet                   # Creating Private Subnets
 resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.private_subnets}"          # CIDR block of private subnets
 }

 #Route table for Public Subnets
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
 }

 #Route table for Private Subnet's
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
 }

 #Route table Association with Public Subnet's
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnets.id
    route_table_id = aws_route_table.PublicRT.id
 }
 
 #Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnets.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
 }
 
 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets.id
 }

# Security group for nodes

resource "aws_security_group" "nodes" {

  name    = "k3s nodes Security Group"
  vpc_id  = aws_vpc.Main.id

  ingress {
    description = "ssh"
    from_port   = "22"
    to_port  = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   
  }

    ingress {
    description = "k3s API"
    from_port   = "6443"
    to_port  = "6443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Acceso a API desde fuera de la VPC
    #cidr_blocks = ["10.0.0.128/26"] # Corresponde a la red pública donde se implementa el cluster
  }

    ingress {
    description = "public internal"
    from_port   = "0"
    to_port  = "65535"
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.128/26"] # Corresponde a la red pública donde se implementa el cluster
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }

     tags = {
    Name = "k3s-nodes-sg"
  }

}

# EC2 Cluster Init

module "ec2_k3s_main" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "tokio"

  ami                         = "ami-02d1e544b84bf7502"
  instance_type               = "t2.medium"
  key_name                    = "us-east-2-lab"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = aws_subnet.publicsubnets.id
  user_data                   = file("k3s-server.sh")
  tags = {
    Terraform                 = "true"
    Environment               = "dev"
  }
}

# module "ec2_k3s_east" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"
#   name                        = "london"
#   ami                         = "ami-02d1e544b84bf7502"
#   instance_type               = "t2.medium"
#   key_name                    = "us-east-2-lab"
#   monitoring                  = true
#   vpc_security_group_ids      = [aws_security_group.nodes.id]
#   subnet_id                   = aws_subnet.publicsubnets.id
#   user_data                   = file("k3s-node.sh")
#   tags = {
#     Terraform                 = "true"
#     Environment               = "dev"
#   }
# }


#
/* module "ec2_k3s_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["01"])

  name = "nd-${each.key}"
  #ami                         = "ami-02f3416038bdb17fb" #Ubuntu 22.04
  ami                        = "ami-02d1e544b84bf7502" # Amazon Linux 2
  instance_type               = "t2.medium"
  key_name                    = "us-east-2-lab"
  monitoring                  = true
  vpc_security_group_ids     = [aws_security_group.nodes.id]
  subnet_id                   = aws_subnet.publicsubnets.id
  user_data                   = file("k3s-node.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
 */
