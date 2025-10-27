module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.6.1"

  # Cluster configuration
  cluster = {
    name    = local.cluster_name
    version = "1.29"
    endpoint_public_access = true
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Node groups
  eks_managed_node_groups = {
    panda-node = {
      desired_capacity = 2
      min_capacity     = 2
      max_capacity     = 4

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "Panda_Node"
      }
    }
  }

  # Tags
  tags = local.tags
}
