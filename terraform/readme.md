# MernStack project Infra Setup

## Clone the repo and change to terraform directory
clone https://github.com/kunj134/mern-infra.git
cd mern-infra/terraform

## Configure Provider credentials from below commands.
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="us-west-2"

## Create infra setup using terraform commands
$ terraform init
$ terraform plan
$ terraform apply
