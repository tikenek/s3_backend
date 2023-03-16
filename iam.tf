resource "aws_iam_role" "s3_backend_role" {
  name = "s3-backend-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_backend_policy" {
  name        = "s3-backend-policy"
  description = "Policy for S3 backend to access DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = aws_dynamodb_table.lock.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_backend_policy_attachment" {
  policy_arn = aws_iam_policy.s3_backend_policy.arn
  role       = aws_iam_role.s3_backend_role.name
}

resource "aws_iam_policy" "s3_backend_s3_policy" {
  name        = "s3-backend-s3-policy"
  description = "Policy for S3 backend to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ListBucketObjects"
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::your-bucket-name"
        ]
      },
      {
        Sid      = "GetObject"
        Effect   = "Allow"
        Action   = [
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::your-bucket-name/*"
        ]
      },
      {
        Sid      = "PutObject"
        Effect   = "Allow"
        Action   = [
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::your-bucket-name/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_backend_s3_policy_attachment" {
  policy_arn = aws_iam_policy.s3_backend_s3_policy.arn
  role       = aws_iam_role.s3_backend_role.name
}
