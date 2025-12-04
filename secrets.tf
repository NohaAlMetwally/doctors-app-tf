data "aws_secretsmanager_secret" "db" {
  arn = "arn:aws:secretsmanager:us-east-1:757260700200:secret:edoc-db-credentials-TCLGaJ"
}

data "aws_secretsmanager_secret_version" "db" {
  secret_id = data.aws_secretsmanager_secret.db.id
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.db.secret_string)
}