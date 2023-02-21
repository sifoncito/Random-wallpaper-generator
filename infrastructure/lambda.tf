resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.http-crud-tutorial-lambda.name
  policy_arn = aws_iam_policy.policy_for_lambda.arn
}

data "archive_file" "zip_python_code" {
  type        = "zip"
  source_file = "../main.py"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "random_wallpaper_function" {
  filename      = "lambda_function.zip"
  function_name = "RandomWallpaper"
  role          = aws_iam_role.http-crud-tutorial-lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  layers        = ["arn:aws:lambda:us-east-1:770693421928:layer:Klayers-p39-pillow:1"]
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_scheduler_schedule" "schedule_lambda_execution" {
  name       = "schedule_lambda"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "rate(24 hour)"

  target {
    arn      = aws_lambda_function.random_wallpaper_function.arn
    role_arn = aws_iam_role.role_for_evenbridge.arn
  }
}
