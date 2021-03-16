resource "ibm_iam_access_group" "accgroupdevops"{
  name = var.access_group_name_devops
  description= var.desc_access_devops
}

data "ibm_resource_group" "group" {
name= var.resource_group_name
}


resource "ibm_iam_access_group_members" "accgroupmemdevops" {
  access_group_id = ibm_iam_access_group.accgroupdevops.id
  ibm_ids         = ["var.ibm_ids_devops"]
}
resource "ibm_iam_access_group_policy" "policy5r" {
  access_group_id = ibm_iam_access_group.accgroupdevops.id
  roles        = ["var.ibm_roles_devops"]

resources { 
    resource_group_id = data.ibm_resource_group.group.id
  }
}

