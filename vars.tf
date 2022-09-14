variable "region" {
    
}
 variable "main_vpc_cidr" {}
 variable "public_subnets" {}
 variable "private_subnets" {}


variable k3s_workers {
  description = "Workers K3S"
  type     = map
  default  = {
    worker01 = {
      name  = "worker01",
    },
    worker02 = {
      name    = "worker02"
    }
  }
}