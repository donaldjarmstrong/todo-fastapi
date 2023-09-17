resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "ToDo"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  ttl {
    attribute_name = "expires"
    enabled        = true
  }

  global_secondary_index {
    name            = "UserIdIdx"
    hash_key        = "user_id"
    write_capacity  = 5
    read_capacity   = 5
    projection_type = "ALL"
  }

  tags = {
    Name        = "ToDo"
    Environment = "PRODUCTION"
  }
}