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
  key_protect = "crn:v1:bluemix:public:kms:us-south:a/1d174ce6f86f187bf5a54d9f60da6cdb:04428ef2-8912-4c27-8172-df90f63ceffc:key:0c7ce708-c8a6-47ff-bb29-674c43961f49"

}

resource "ibm_cos_bucket" "standard-objectstorage_dbbackup" {
  bucket_name = var.bucket_dbbackup
  resource_instance_id = ibm_resource_instance.service-instance-objectstorage.id
  region_location  = var.bucket_region
  storage_class = var.storage_class
  key_protect = "crn:v1:bluemix:public:kms:us-south:a/1d174ce6f86f187bf5a54d9f60da6cdb:04428ef2-8912-4c27-8172-df90f63ceffc:key:0c7ce708-c8a6-47ff-bb29-674c43961f49"

}

