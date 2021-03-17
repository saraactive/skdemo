data "ibm_resource_group" "group"{
name= var.resource_group_name
}


resource "ibm_resource_instance" "service-instance-objectstorage" {
name = var.service_instance_name_objectstorage
service = var.service_objectstorage
plan = var.plan_objectstorage
location = var.object_location
resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_cos_bucket" "standard-objectstorage" {
  bucket_name = var.bucket_logdna
  resource_instance_id = ibm_resource_instance.service-instance-objectstorage.id
  region_location  = var.bucket_region
  storage_class = var.storage_class
  key_protect = "crn:v1:bluemix:public:kms:us-south:a/696f30460baa4d99b418f85826298ddb:cb8815a5-f523-42c3-b744-4087cbb9ebb5:key:4d83f25f-8d13-48d2-8fa3-abd165d2bb39"

}


