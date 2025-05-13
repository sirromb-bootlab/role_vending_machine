# In addition to these required tags, you must ALSO tag all resources with `Name`, where applicable.
# You may provide other tags at the individual resource level as well.

# For more details on tag requirements, see https://ambrygen.atlassian.net/wiki/spaces/ITOPSDOC/pages/9434038309/Tagging

# REQUIRED TAGS - Add values to each before deploying your Terraform code.
locals {
  Owner       = "bmorris-contractor@me.com"       # Email address of the business owner GROUP. This should NOT be a named individual. It should be a distribution list email.
  Deployment  = "Terraform"                                               # one of: ag, tempus
  Environment = "dev"                                              # Must be one of: dev, tst, stg, prd. Can be pulled dynamically from variables if you deploy to multiple environments and specify config via a tfvars file.
  Project     = "platform"                                         # Name of the application or service this resource belongs to. (eg. secondary-analysis, ap, cancernext, cardio, exome, skm, tracker, monitoring, adaudit, overhead)
  Criticality = "dev"                                             # one of: tier1, tier2, tier3, none. tier1 is most critical.
  Repo        = "https://github.com/ambrygen/role-vending-machine" # The URL of the IAC repo that contains this application's code. (eg. https://github.com/<MY_GITHUB_ORG>/i_copied_the_default_value)

  # OPTIONAL TAGS - These tags are not required globally but can be added as needed
  optional_tags = {
    map-migrated = "migIPLS0G0ZM5" # allows AWS MAP credits to be applied to your resources

    # expiration-date = "" # TODO - What format should be used here? ISO-8601 yyyy-MM-dd?
    # tearcode        = "" # Maybe you want to include a tearcode!

    # Only required for Bio Account resources
    # run-id = "" # eg. 231109_A01310_0766_BHLLHJDRX3

    # Only required if you are deploying EC2/EBS resources
    # backup-policy = "" # one of: a-west-test-ec2-policy, a-west-staging-ec2-policy, a-west-prod-ec2-policy
  }
}

#######################################################################
# DON'T MODIFY BELOW THIS LINE UNLESS YOU REALLY KNOW WHAT YOU'RE DOING
#######################################################################
module "tagging_module" {
  # checkov:skip=CKV_TF_1: commit hashing is superfluous for this case
  # For details on exact tag validation, see the repo below
  source = "github.com/sirromb-bootlab/terraform-aws-tagging-module//terraform?ref=v1.0.0"
  # Required tags
      Project     = local.Project     # Which platform/project created this infra
      Deployment  = local.Deployment  # Mechanism used to deploy the resource (eg. Terraform)
      Environment = local.Environment # Environment in which the resource is deployed. One of: dev, preprod, prod
      Repo        = local.Repo        # URL of the repository where the Infrastructure as Code is sourced from.
      Criticality = local.Criticality # The level of criticality for the application. Informs RPO and RTO. One of: critical, prod-non-critical, internal, dev
      Owner       = local.Owner       # Email address of the owner or owner distribution list.

  # Optional tags
  optional_tags = local.optional_tags
}
