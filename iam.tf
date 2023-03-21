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

  tags = var.tags
}

resource "aws_iam_policy" "s3_backend_policy" {
  name = "s3-backend-policy"
  description = "Policy for S3 backend to access DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = aws_dynamodb_table.db_lock.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_backend_policy_attachment" {
  policy_arn = aws_iam_policy.s3_backend_policy.arn
  role = aws_iam_role.s3_backend_role.name
}

resource "aws_iam_policy" "s3_backend_s3_policy" {
  name = "s3-backend-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ListBucketObjects"
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::sandbox-vpc-tynar-s3-backend"
        ]
      },
      {
        Sid = "GetObject"
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::sandbox-vpc-tynar-s3-backend/*"
        ]
      },
      {
        Sid = "PutObject"
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::sandbox-vpc-tynar-s3-backend/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_backend_s3_policy_attachment" {
  policy_arn = aws_iam_policy.s3_backend_s3_policy.arn
  role = aws_iam_role.s3_backend_role.name
}

resource "aws_iam_policy" "cloudtrail_s3_policy" {
  name        = "tynar-vpc-cloudtrail-s3-policy"
  description = "Policy for CloudTrail to write logs to an S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowCloudTrailToWriteToS3Bucket",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetBucketAcl"
        ],
        Resource = [
          "${aws_s3_bucket.my_bucket.arn}",
          "${aws_s3_bucket.my_bucket.arn}/*"
        ],
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
