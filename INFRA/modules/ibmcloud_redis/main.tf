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
    key_protect_key = "crn:v1:bluemix:public:kms:us-south:a/696f30460baa4d99b418f85826298ddb:cb8815a5-f523-42c3-b744-4087cbb9ebb5:key:4d83f25f-8d13-48d2-8fa3-abd165d2bb39"
  }
}


