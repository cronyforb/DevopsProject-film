module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.6.1"

  cluster_name    = local.cluster_name
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  cluster_addons = ["coredns", "vpc-cni", "kube-proxy"]

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

  tags = local.tags
}
