data "ibm_resource_group" "group"{
name= var.resource_group_name
}


resource ibm_container_alb_cert cert {
  cert_crn    = "crn:v1:bluemix:public:cloudcerts:us-south:a/e9021a4dc47e3d:faadea8e-a7f4-408f-8b39-2175ed17ae62:certificate:3f2ab474fbbf9564582"
  secret_name = "test-sec"
  cluster_id     = "<cluster_ID>"
}

