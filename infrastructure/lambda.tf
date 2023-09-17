resource "null_resource" "pip_install" {
  triggers = {
    shell_hash = "${sha256(file("${local.api_root_dir}/requirements.txt"))}"
  }

  provisioner "local-exec" {
    command = "cd ${local.api_root_dir}; pipenv run pip install -r requirements.txt --no-deps -t ${path.module}/layer"
  }
}

data "archive_file" "lambda_source" {
  type        = "zip"
  source_file = "${local.api_root_dir}/lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda_source.output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256

  function_name = "todo-api"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda.handler"

  runtime = "python3.11"
}
