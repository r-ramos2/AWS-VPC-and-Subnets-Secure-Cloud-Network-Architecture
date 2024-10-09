resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
  name              = "/aws/vpc/flowlogs/my-secure-vpc"
  retention_in_days = 30

  tags = {
    Name = "vpc-flow-log-group"
    Environment = "Production"
  }
}

resource "aws_vpc_flow_log" "flow_log" {
  vpc_id = aws_vpc.my_vpc.id
  log_destination = aws_cloudwatch_log_group.vpc_flow_log_group.arn
  traffic_type = "ALL" # Captures all traffic (accepted, rejected, all)

  tags = {
    Name = "vpc-flow-log"
    Environment = "Production"
  }
}

