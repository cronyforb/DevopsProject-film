module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  # Cluster configuration
  cluster_name    = "amazon-prime-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Managed Node Group
  eks_managed_node_groups = {
    panda-node = {
      desired_capacity = 2
      min_size         = 1
      max_size         = 3
      instance_types   = ["t2.medium"]
    }
  }

  tags = local.tags
}
