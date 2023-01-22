## Local Environments For Smart People

This repository aims to simplyfy the development of cloud applications by combining open-source tools and orchestration systems to build local development environments.

## Pre-requistes

The goal is to make it really simple and have a low barrier to entry - this means that we want to keep the pre-requistes to the minimum - so you only need the following:

1. Docker Desktop (or any other OCI compliant enginer)

## Tools Used

The focus is to simplify cloud applications development focused around serverless model - this is an opinionated way of developing serverless cloud applications and such will use a specific set of tools. We will be primarily focusing on AWS serverless technologies like S3, lambdas, DynamoDB etc. Here is a list of tools being used.

1. [Localstack](https://docs.localstack.cloud/getting-started/)
2. [Serverless](https://www.serverless.com/framework/docs/getting-started/)
3. [NodeJs](https://nodejs.org/en/docs/guides/getting-started-guide/)

This repository will contain the code to build tools and images that can be used by engineers building applications using AWS serverless technologies.

## Repository Structure

```
root---|
       |---
       |   |---.github (Github related code and docs - like pull request templates, actions configurations etc.)
       |
       |
       |---
       |   |---docker (Docker related code such as image files, docker-compose files etc.)
       |
       |
       |---
       |   |---docs (Documentation)
       |
       |
       |---
       |   |---scripts (scripts for various setup and in-container setup - example installing the runtimes in the images, starting runtimes etc.)
       |
       |
       |---
       |   |---src (source code for tools and helpers to be packaged inside the containers)
       |
       |
       |---
       |   |---test (tests for the code for tools and helpers)
       |
       |
       |---README.md (Start here for documentation)
```

## Documentation

The tools and conventions promoted by this repository are being documented in the documentation folder. You can start with the [Index](./docs/README.md) file and work your way in to specific topics

## Contributions

If you are looking for ways to contribute please refer to [Contributions Guidelines](./CONTRIBUTING.md).
