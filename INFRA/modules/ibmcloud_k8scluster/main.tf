data "ibm_resource_group" "group"{
name= var.resource_group_name
#depends_on = ["ibm_resource_group.group"]
}
resource "ibm_container_cluster" "cluster" {
  name              = var.cluster_name
  datacenter        = var.datacenter
  resource_group_id = data.ibm_resource_group.group.id
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
  kube_version      = var.kube_version
  machine_type      = var.machine_type
  hardware          = var.hardware_type
  default_pool_size = var.default_pool_size

}
resource "ibm_container_alb_cert" "cert" {
  cert_crn    = var.cert_crn
  secret_name = var.secret_name
  cluster_id  = ibm_container_cluster.cluster.id
}
