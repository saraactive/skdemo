variable "apikey" {}
variable "region" {}
variable "location" {}
variable "space" {}
variable "org" {}
variable "resource_group_name"{}

variable "service_key_protect" {
  description = "Key protect ibm cloud service name "
  default = "kms"
} 

variable "plan_key_protect" {
 description = "Key protect plan"
 default = "tiered-pricing"
}
variable "service_instance_name_key_protect" {}
variable "keyprotect_key" {}
variable "keyprotect_key_prod" {}

variable "plan_appid" {
  description = "appid plan"
  default = "graduated-tier"
}
variable "service_appid" {
  description = "appid service name " 
  default = "appid" 
}
variable "service_instance_name_appid" {}

variable "plan_appconnect" {
   description = "appconnect plan "
   default = "appconnectplanenterprise"
}
variable "service_appconnect" {
   description = "ibm cloud appconnect service name "
   default = "AppConnect"
}
variable "service_instance_name_appconnect" {}




variable "plan_redis" {
   description = "redis plan"
   default = "standard"
}
variable "service_redis" {
   description = "Cloud service name for redis"
   default = "databases-for-redis"
}
variable "service_instance_name_redis" {}

variable "plan_logdna" {
   description = "logdna plan"
   default = "7-day"
}
variable "service_logdna" {
   description = "Cloud service name for logdna"
   default = "logdna"
}
variable "service_instance_name_logdna" {}
variable "logdna_key" {}


variable "datacenter" {}
variable "machine_type" {
  description= "workernode machine type"
  default= "b3c.4x16" 
}
variable "cluster_name" {}
variable "hardware_type" {
  description = "Type of workernode hardware"
  default= "dedicated"
}
variable "plan" {
  description = "cluster plan"
  default = "standard"
}
variable "default_pool_size"{}
variable "public_vlan_id" {}
variable "private_vlan_id" {}
variable "cert_crn" {}
variable "secret_name" {}
variable "kube_version" {}

variable "service_instance_name_objectstorage" {}
variable "service_objectstorage" {
   description = "ibm cloud service name"
   default = "cloud-object-storage"
}
variable "plan_objectstorage" {
   description = "object storage plan"
   default = "standard"
}
variable "bucket_logdna" {}
variable "storage_class" {
   description = "storage class"
   default = "smart"
}
variable "bucket_region" {}
variable "object_location" {
   description = "object storage location "
   default = "global"
}

