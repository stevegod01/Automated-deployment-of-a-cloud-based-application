## Setup
Follow https://persuadeloyalty.atlassian.net/wiki/spaces/PRSD/pages/3209953281/AWS+CLI+Access+for+Loyalty to set up your profile.

Name the profile "links-airlines"


## Deployment

The deployment script ./deploy.sh can be run from this directory to update stacks.  However, if the first time you deploy an environment, you'll need to do manual steps to get AcmCert, GithubActionsOidc, and code deployments to work.  See the order below.

- Deploy Vpc.yaml
- Deploy EcsCluster.yaml
- Deploy EcrRepo.yaml
- Deploy AcmCert.yaml
    - Get DNS values from links Airlines Console during deployment
        - https://us-east-1.console.aws.amazon.com/acm/home?region=us-east-1#/certificates/list
    - Quickly go into Dell AWS and set DNS records
    - Wait for Validation
- Deploy Secret.yaml
- Deploy EcsIam.yaml- Now go into repo and add github workflows and create task definition.json.  Add IAM roles from EcsIam.yaml into task definition.json
- Now update GithubActionsOidc.yaml with roles from EcsIam.yaml and deploy
- Update github action with the role created by GithubActionsOidc.yaml
- Now deploy code via github action to update container and task def into AWS.
    - Will fail due to missing ECS service / Cluster
- Deploy RDS
- Now create a service manually in AWs and delete it to generate the ECS service role
- Deploy EcsService.yaml
- Deploy  via github actions again to test end to end
