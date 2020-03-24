#! /bin/bash

set -eo pipefail

export AWS_DEFAULT_REGION='us-east-2'

echo "Finding Node Role"
STACK_NAME=$(eksctl get nodegroup --name ng-2 --cluster "outposts" -o json | jq -r '.[].StackName')
ROLE_NAME=$(aws cloudformation describe-stacks --stack-name $STACK_NAME | jq -r '.Stacks[].Outputs[] | select(.OutputKey=="InstanceRoleARN") | .OutputValue' | cut -f2 -d/)
echo "Found Node Role $ROLE_NAME"
echo "Applying Falco Role to $ROLE_NAME"

aws iam create-policy --policy-name EKS-CloudWatchLogs --policy-document file://./iam/iam_role_policy.json || true
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn `aws iam list-policies | jq -r '.[][] | select(.PolicyName == "EKS-CloudWatchLogs") | .Arn'` || true
