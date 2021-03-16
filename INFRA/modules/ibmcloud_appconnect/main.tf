data "ibm_space" "spacedata"{
space = var.space
org = var.org 
}

resource "ibm_service_instance" "service-appconnect" {
name = var.service_instance_name_appconnect
space_guid = data.ibm_space.spacedata.id
service = var.service_appconnect
plan = var.plan_appconnect
}
