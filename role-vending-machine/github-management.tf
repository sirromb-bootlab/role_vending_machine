module "example_security_inf_repo_Development" {
  source                   = "../github-workflow-roles"
  github_organization_name = var.default_github_organization_name
  providers = {
    aws = aws.Development
  }
  repository_name = "github_repository_management"
  github_branch   = "main"
  principal_type  = "github"
}

# data "aws_iam_policy_document" "example_security_inf_repo_Development_permissions" {
#   # Specify the permissions that your workflow role needs using this resource
#   statement {
#     sid    = "CreateS3buckets"
#     effect = "Allow"

#     actions = [
#       "s3:CreateBucket",
#       "s3:DeleteBucket",
#       "s3:DeleteBucketPolicy",
#       "s3:PutBucketPolicy",
#       "s3:PutBucketOwnershipControls",
#       "s3:PutEncryptionConfiguration",
#       "s3:PutBucketTagging",
#       "s3:PutBucketPublicAccessBlock",
#       "s3:PutBucketAcl",
#       "s3:PutBucketLogging",
#       "s3:PutBucketVersioning",
#       "s3:PutLifecycleConfiguration",
#       "s3:PutBucketNotification"
#     ]
#     resources = [
#       "arn:aws:s3:::centralized-s3-access-logs",
#       "arn:aws:s3:::centralized-s3-access-logs/*",
#     ]
#   }
#   statement {
#     sid    = "SQSQueues"
#     effect = "Allow"

#     actions = [
#       "sqs:CreateQueue",
#       "sqs:DeleteQueue",
#       "sqs:TagQueue",
#       "sqs:UntagQueue",
#       "sqs:SetQueueAttributes"
#     ]
#     # Instead of hard-coding account numbers, reference the variable names stored in the `variables-accounts` manifest
#     resources = ["arn:aws:sqs:*:${var.account_Development}:aws-s3-access-logs"]
#   }
# }
