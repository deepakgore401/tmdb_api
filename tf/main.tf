provider "aws" {
  region = "ap-south-1"  # Replace this with your desired AWS region
}

# IAM Role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_api_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource  "aws_lambda_function" "my_lambda_function" {
 filename = "${path.module}/../python/getdataapi.zip"
 function_name = "tmdb_api_lambda_function"
 description = "Lambda funnction for ingestion of tmdb api"
 role = aws_iam_role.lambda_execution_role.arn
 handler = "getdataapi.get_movie_data"
 runtime = "python3.8"
 timeout = 360
}

