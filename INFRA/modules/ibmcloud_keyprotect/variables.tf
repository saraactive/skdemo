variable "resource_group_name" {
   description = "Resource Group Control environment"
   type = string
} 



variable "service_key_protect" {
  description = "key protect service name"
  type        = string

}
variable "plan_key_protect" {
   description = "key protect plan"
    type        = string
}
variable "service_instance_name_key_protect" {
  description = "key protect service instance  name"
  type        = string
}
variable "location" {
  description = "key protect service location"
  type        = string
}
variable "keyprotect_key" {
   description = "root key name"
   type = string
}

variable "keyprotect_key_prod" {
   description = "root key name"
   type = string
 }
variable "resource_group_id" {}
