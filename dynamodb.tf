resource "aws_dynamodb_table" "lock" {
  name           = var.dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  global_secondary_index {
    name            = "LockIndex"
    hash_key        = "LockID"
    projection_type = "ALL"
    write_capacity  = 20
    read_capacity   = 20
  }

  tags = var.tags
}
