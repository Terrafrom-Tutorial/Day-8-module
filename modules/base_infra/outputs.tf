output "vpc_name" {
  value = aws_vpc.my_VPC.tags.Name
}

output "vpc_id" {
  value = aws_vpc.my_VPC.id
}

output "public_rtb_id" {
  value = aws_route_table.pub_rtb.id
}
output "vpc_cidr" {
  value = aws_vpc.my_VPC.cidr_block
}