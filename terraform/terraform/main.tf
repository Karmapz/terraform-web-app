module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.public_subnet_ids
  instance_type = var.instance_type
}

module "alb" {
  source       = "./modules/alb"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  instance_ids = module.ec2.instance_ids
}

module "s3" {
  source = "./modules/s3"
}
