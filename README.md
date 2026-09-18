# AWS application deployment reference

This repository is a partial collection of AWS CloudFormation, ECS task definitions, and Java container build configuration. It is useful for reviewing how networking, compute, a database, queues, IAM, and GitHub OIDC were connected in an existing deployment design. It does not include the application source or a complete, independently reproducible deployment.

## Start here

| Path | What it contains | Current limitation |
| --- | --- | --- |
| [`aws/`](aws/) | Numbered CloudFormation templates for VPC, ECS, ECR, ACM, secrets, SQS, IAM, a load balancer, RDS, service, and bastion resources | Account, environment, DNS, and dependency assumptions require review |
| [`aws/README.md`](aws/README.md) | Historical environment setup and deployment sequence | References organization-specific access and manual steps; not general setup instructions |
| [`aws/deploy.sh`](aws/deploy.sh) | Existing ordered stack-deployment script | Uses the `links-airlines` AWS profile and can perform AWS SSO login and change infrastructure |
| [`aws/900-GithubActionsOidc.yaml`](aws/900-GithubActionsOidc.yaml) | GitHub OIDC role configuration | Retains original organization/repository assumptions |
| [`task-definition.dev.json`](task-definition.dev.json), [`task-definition.prod.json`](task-definition.prod.json) | ECS task definitions | Environment-specific resource references must be reconciled before reuse |
| [`GithubActionOicdOld.yml`](GithubActionOicdOld.yml) | Historical workflow example | Lives outside `.github/workflows/`; GitHub does not execute it here |
| [`pom.xml`](pom.xml), [`Dockerfile`](Dockerfile) | Spring Boot dependency/build descriptor and two-stage Java image definition | No `src/` application or test tree is included, so the expected executable JAR is not reproducible from this checkout |

## Scope and gaps

The Maven file declares Spring Boot `2.6.7` and Java `1.8`; the Docker build and runtime use Java 11 images. These are preserved historical settings, not a tested current runtime recommendation. There is no active GitHub Actions workflow, automated test suite, recorded template-validation result, or verified deployment outcome in this checkout.

The templates and notes include existing project and organization identifiers. Their provenance, the repository owner's exact contribution, and redistribution permissions have not yet been documented. This README makes no sole-authorship or client-delivery claim and grants no new license. Original references remain intact for attribution and follow-up.

## Before adapting this reference

1. Establish the original source, authorship, permissions, and the intended environment.
2. Restore or supply the missing application and tests, and reconcile the Maven/container runtime versions.
3. Review template dependencies, account-specific identifiers, IAM trust, DNS, database parameters, and task definitions against the target environment.
4. Add local template validation and application tests before designing a deployment workflow with separately controlled credentials and approval.
5. Record a verified architecture, deployment/rollback sequence, and cleanup procedure if this becomes an active project.

Reading these files requires no AWS account. Do not treat `aws/deploy.sh` as a local validation command: it performs real infrastructure operations. This documentation update did not run it or validate the repository against an AWS environment.
