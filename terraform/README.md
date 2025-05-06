# Terraform Challenge

## Intro

Please create a directory that contains Terraform configuration that can deploy a Lambda, DynamoDB table and SQS queue into AWS. This Lambda must have a SQS trigger, and then be able to write data onwards to DynamoDB.

**Note:**

You do not have to include application code for the Lambda.

## Requirements

Your configuration must follow the below specification:

**Generic:**
- Your state file must be stored remotely.
- Any supporting configuration such as IAM policies
- Designed in a way it can be deployed to two different environments. i.e.,
development and production
- Sensible tagging in place to differentiate between environments.
- You may call the resources whatever you wish.

**Lambda:**
- You may choose any language of choice for the Lambda engine.
- It must be able to publish metrics and logs to CloudWatch and traces to X-Ray.

**DynamoDB:**
- You must enable TTL.
- The table should be able to scale infinitely.
- There must be a hash key of ID and a sort key of userId.
- The data can be recovered at any chosen point.

**SQS:**
- A sensible redrive policy fit for a production environment is required.
- You do not need to worry about how data gets onto the queue.