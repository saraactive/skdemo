
data "ibm_resource_group" "group"{
name= var.resource_group_name
}


resource "ibm_resource_instance" "service-instance_key_protect" {
name = var.service_instance_name_key_protect
service = var.service_key_protect
location= var.location
plan = var.plan_key_protect
resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_kp_key" "resource_key_test" {
  key_protect_id  = ibm_resource_instance.service-instance_key_protect.guid
  key_name     = var.keyprotect_key
  standard_key = false
}
resource "ibm_kp_key" "resource_key_prod" {
  key_protect_id  = ibm_resource_instance.service-instance_key_protect.guid
  key_name     = var.keyprotect_key_prod
  standard_key = false
}

