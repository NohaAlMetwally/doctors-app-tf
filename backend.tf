terraform {
  backend "s3" {
    bucket         = "doctors-app-statefile"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "doctors-app-tf-statelock"
  }
}