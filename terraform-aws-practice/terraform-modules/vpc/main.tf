resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags                 = merge(var.common_tags, var.vpc_tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, var.igw_tags)
}

resource "aws_subnet" "pub_subnets" {
  count                   = length(local.az_names)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnets[count.index]
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(var.common_tags)
}

resource "aws_subnet" "private_subnets" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = local.az_names[count.index]
  tags              = merge(var.common_tags)
}

resource "aws_subnet" "db_subnets" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnets[count.index]
  availability_zone = local.az_names[count.index]
  tags              = merge(var.common_tags)
}

resource "aws_db_subnet_group" "default" {
  name       = local.name
  subnet_ids = aws_subnet.db_subnets[*].id
  tags = {
    Name = "${local.name}"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub_subnets[0].id
  tags          = merge(var.ngw_tags)
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    {
      Name = "${local.name}-public"
    }
  )
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name}-private"
    }
  )
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${local.name}-database"
    }
  )
}

resource "aws_route" "database_route" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.pub_subnets)
  subnet_id      = element(aws_subnet.pub_subnets[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count          = length(var.db_subnets)
  subnet_id      = element(aws_subnet.db_subnets[*].id, count.index)
  route_table_id = aws_route_table.database.id
}
