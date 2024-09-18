module "vpcA" {
  source = "../modules/base_infra"
  vpc_cidr    = var.vpc_a_cidr
  vpc_name    = var.vpc_a_name
  subnet_cidr = var.vpc_a_subnet_cidr
}

module "vpcB" {
  source      = "../modules/base_infra"
  vpc_cidr    = var.vpc_b_cidr
  vpc_name    = var.vpc_b_name
  subnet_cidr = var.vpc_b_subnet_cidr
} 

resource "aws_vpc_peering_connection" "peer" {
  auto_accept = true
  peer_vpc_id = module.vpcB.vpc_id
  vpc_id = module.vpcA.vpc_id
  tags = {
    Name = "VPC-A to VPC-B"
  }
  }

  resource "aws_route" "vpc_a_to_vpc_b" {
  route_table_id         = module.vpcA.public_rtb_id
  destination_cidr_block = module.vpcB.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on = [ module.vpcA, module.vpcB ]
}

resource "aws_route" "vpc_b_to_vpc_a" {
  route_table_id         = module.vpcB.public_rtb_id
  destination_cidr_block = module.vpcA.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on = [ module.vpcA, module.vpcB ]
}