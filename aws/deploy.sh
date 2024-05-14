#!/bin/bash

export AWS_PROFILE=links-airlines
# Login if creds have expired
aws sts get-caller-identity > /dev/null || aws sso login

set -e


# Skip 9XX-*.yaml files
TEMPLATES=$(ls ./0*.yaml)

ENVIRONMENT_NAME=Dev
for TEMPLATE in $TEMPLATES; do
        STACK=$(echo "$TEMPLATE" | cut -f2 -d '-' | cut -f1 -d '.')
        echo "$TEMPLATE"

        aws cloudformation deploy \
            --template-file "$TEMPLATE" \
            --stack-name "$ENVIRONMENT_NAME$STACK" \
            --capabilities CAPABILITY_NAMED_IAM \
            --parameter-overrides \
                EnvironmentName="$ENVIRONMENT_NAME";
done;

# ENVIRONMENT_NAME=Prod
# for TEMPLATE in $TEMPLATES; do
#         STACK=$(echo "$TEMPLATE" | cut -f2 -d '-' | cut -f1 -d '.')
#         echo "$TEMPLATE"

#         aws cloudformation deploy \
#             --template-file "$TEMPLATE" \
#             --stack-name "$ENVIRONMENT_NAME$STACK" \
#             --capabilities CAPABILITY_NAMED_IAM \
#             --parameter-overrides \
#                 EnvironmentName="$ENVIRONMENT_NAME";
# done;


# Deploy Github Actions OIDC
aws cloudformation deploy \
    --template-file 900-GithubActionsOidc.yaml \
    --stack-name GithubActionsOidc \
    --capabilities CAPABILITY_NAMED_IAM