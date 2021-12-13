provider "aws" {
  region = "us-east-1"
}

data "aws_iam_policy_document" "website_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "arn:aws:s3:::${var.tag_bucket_name}/*"
    ]
  }
}


resource "aws_s3_bucket" "test_bucket" {
  bucket = var.tag_bucket_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.website_policy.json

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name        = var.tag_bucket_name
    Created_by  = var.tag_owner
    Environment = var.tag_bucket_environment
  }
}

