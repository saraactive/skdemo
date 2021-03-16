data "ibm_resource_group" "group"{
name= var.resource_group_name
}

resource "ibm_resource_instance" "service-instance-appid" {
name = var.service_instance_name_appid
service = var.service_appid
location= var.location
plan = var.plan_appid
resource_group_id = data.ibm_resource_group.group.id
}
