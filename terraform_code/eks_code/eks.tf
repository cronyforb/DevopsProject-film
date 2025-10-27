module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name    = local.name
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

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

