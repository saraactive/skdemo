data "ibm_resource_group" "group" {
name= var.resource_group_name
}
resource "ibm_resource_instance" "service-instance_logdna" {
name = var.service_instance_name_logdna
service = var.service_logdna
location= var.location
plan = var.plan_logdna
resource_group_id = data.ibm_resource_group.group.id
}
resource "ibm_resource_key" "resource_key_name" {
name = var.logdna_key
role = "Manager"
resource_instance_id= ibm_resource_instance.service-instance_logdna.id
}
resource "null_resource" "logdna_config" {
  provisioner "local-exec" {
    command = <<EOF
        ibmcloud login --apikey "${var.apikey}" -r "${var.region}" -g "${var.resource_group_name}"
        ibmcloud ks cluster config --cluster "${var.cluster_name}"
        kubectl create secret generic logdna-agent-key --from-literal=logdna-agent-key="${ibm_resource_key.resource_key_name.credentials.ingestion_key}"
        echo "${ibm_resource_key.resource_key_name.credentials.ingestion_key}"
        kubectl create -f https://assets.us-south.logging.cloud.ibm.com/clients/logdna-agent-ds.yaml
        kubectl patch ds/logdna-agent -p '{"spec":{"updateStrategy":{"type":"RollingUpdate", "maxUnavailable":"100%"}}}'
        kubectl patch ds/logdna-agent -p '{"spec":{"template":{"spec":{"containers":[{"name":"logdna-agent","image":"logdna/logdna-agent-v2:stable", "imagePullPolicy": "Always"}]}}}}'
EOF
  }
}

