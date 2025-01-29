# Variable use is not allowed, must be hard-coded to the account you want to apply to
terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "124355666125-tf-remote-state"
    dynamodb_table = "tf-state-lock"
    key            = "github.com/sirromb-bootlab/role-vending-machine.git"
    region         = "us-east-1"
  }
}
