terraform {
  backend "s3" {
    bucket                      = "bucketname"
    key                         = "env/terraform.tfstate"
    region                      = "us-south"           
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "s3.us-south.cloud-object-storage.appdomain.cloud"
    access_key                  = "XXXXXXXXXXXXXXXX"
    secret_key                  = "XXXXXXXXXXXXXXX"
  }
}


provider "ibm" {
        ibmcloud_api_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
	region = "us-south"
}



data "ibm_resource_group" "group"{
name= var.resource_group_name
}
module "ibmcloud_resourcegroup" {
    source = "./modules/ibmcloud_resourcegroup"
    resource_group_name = var.resource_group_name
}

module "ibmcloud_keyprotect" {
    source = "./modules/ibmcloud_keyprotect"
    service_instance_name_key_protect = var.service_instance_name_key_protect    
    service_key_protect = var.service_key_protect
    plan_key_protect = var.plan_key_protect
    keyprotect_key = var.keyprotect_key
    keyprotect_key_prod = var.keyprotect_key_prod
    location  = var.location
    resource_group_name = var.resource_group_name
    resource_group_id = data.ibm_resource_group.group.id
}

module "ibmcloud_appid" {
    source = "./modules/ibmcloud_appid"

    resource_group_name= var.resource_group_name
    location= var.location
    service_instance_name_appid= var.service_instance_name_appid
    service_appid= var.service_appid
    plan_appid= var.plan_appid
}

module "ibmcloud_appconnect" {
    source = "./modules/ibmcloud_appconnect"
    resource_group_name= var.resource_group_name
    location= var.location
    space= var.space
    org= var.org
    service_instance_name_appconnect= var.service_instance_name_appconnect
    service_appconnect= var.service_appconnect
    plan_appconnect= var.plan_appconnect
}




module "ibmcloud_redis" {
    source = "./modules/ibmcloud_redis"
    resource_group_name= var.resource_group_name
    location= var.location
    service_instance_name_redis= var.service_instance_name_redis
    service_redis= var.service_redis
    plan_redis= var.plan_redis
    key_protect_id  = ibm_resource_instance.service-instance_key_protect.guid
    keyprotect_key= var.keyprotect_key 
    service_instance_name_key_protect= var.service_instance_name_key_protect
    service-instance_key_protect= var.service_instance_name_key_protect
}

module "ibmcloud_logdna" {
    source = "./modules/ibmcloud_logdna"
    resource_group_name=var.resource_group_name
    location= var.location
    service_instance_name_logdna= var.service_instance_name_logdna
    service_logdna= var.service_logdna
    plan_logdna= var.plan_logdna
    logdna_key= var.logdna_key
    apikey= var.apikey   
    cluster_name = var.cluster_name
    region = var.region
}

module "ibmcloud_k8scluster" {
    source = "./modules/ibmcloud_k8scluster"

    resource_group_name= var.resource_group_name
    cluster_name= var.cluster_name
    datacenter= var.datacenter
    public_vlan_id= var.public_vlan_id
    private_vlan_id= var.private_vlan_id
    machine_type= var.machine_type
    hardware_type= var.hardware_type
    default_pool_size= var.default_pool_size
    cert_crn= var.cert_crn
    secret_name= var.secret_name
    kube_version= var.kube_version
}

module "ibmcloud_objectstorage" {
    source = "./modules/ibmcloud_objectstorage"
    resource_group_name= var.resource_group_name
    service_instance_name_objectstorage= var.service_instance_name_objectstorage
    service_objectstorage= var.service_objectstorage
    plan_objectstorage= var.plan_objectstorage
    bucket_logdna= var.bucket_logdna
    bucket_backend= var.bucket_backend
    bucket_region= var.bucket_region
    bucket_dbbackup= var.bucket_dbbackup
    storage_class= var.storage_class
    service_instance_name_key_protect= var.service_instance_name_key_protect
    location= var.location
    object_location= var.object_location
    
}


module "ibmcloud_iam" {
    source = "./modules/ibmcloud_iam"
    resource_group_name= var.resource_group_name
    access_group_name_devops= var.access_group_name_devops
    ibm_ids_devops= var.ibm_ids_devops
    ibm_roles_devops= var.ibm_roles_devops
    desc_access_devops= var.desc_access_devops

}

