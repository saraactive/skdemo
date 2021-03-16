data "ibm_resource_group" "group" {
  name = var.resource_group_name
}



data "ibm_resource_instance" "service-instance_key_protect" {
  name              = var.service_instance_name_key_protect
  location          = var.location
  resource_group_id = data.ibm_resource_group.group.id

}


resource "ibm_resource_instance" "service-instance-redis" {
  name              = var.service_instance_name_redis
  service           = var.service_redis
  location          = var.location
  plan              = var.plan_redis
  resource_group_id = data.ibm_resource_group.group.id
  parameters = {
    key_protect_key = "crn:v1:bluemix:public:kms:us-south:a/1d174ce6f86f187bf5a54d9f60da6cdb:04428ef2-8912-4c27-8172-df90f63ceffc:key:0c7ce708-c8a6-47ff-bb29-674c43961f49"
  }
}


