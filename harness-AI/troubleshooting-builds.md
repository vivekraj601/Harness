## Troublehsooting builds with Harness AI
Harness AI Development Assisstant can analyze log files and correlate error messages with known issues. This feature enables developers to troubleshoot and resolve deployment failures quickly, saving them from sifting through millions of log lines. AIDA also suggests fixes and predicts potential errors in the code even before the build is initiated. This feature is designed to work across Harness's CI and CD offerings.

It can help us determine build failures and can provide suggestions to troubleshoot them. Following are the steps we can follow to demonstrate Troubleshooting builds with harness AI:

- Create a repository in Hanress or use Third-party repository like Github (connect using Git connector).
- Use AWS Connector to connect to AWS Account. Just to demonstrate its use case, I haven't provided AWS Authentiocation permissions.

- Create a Pipeline in Harness or we can also provide a pipeline from other repositories. Code for Harness pipeline:
```yml
 pipeline:
  name: flask-app
  identifier: flaskapp
  projectIdentifier: default_project
  orgIdentifier: default
  tags: {}
  properties:
    ci:
      codebase:
        repoName: flask-app
        build: <+input>
  stages:
    - stage:
        name: build
        identifier: build
        description: ""
        type: CI
        spec:
          cloneCodebase: true
          platform:
            os: Linux
            arch: Amd64
          runtime:
            type: Cloud
            spec: {}
          execution:
            steps:
              - step:
                  type: BuildAndPushECR
                  name: BuildAndPushECR_1
                  identifier: BuildAndPushECR_1
                  spec:
                    connectorRef: awsharnessconnector
                    region: ap-southeast-2
                    account: "058264467221"
                    imageName: flask-app-image
                    tags:
                      - flask
    - stage:
        name: Deploy
        identifier: Deploy
        description: ""
        type: Deployment
        spec:
          deploymentType: Kubernetes
          service:
            serviceRef: kubernetes
          environment:
            environmentRef: dev
            deployToAll: false
            infrastructureDefinitions:
              - identifier: devinfra
          execution:
            steps:
              - step:
                  name: Rollout Deployment
                  identifier: rolloutDeployment
                  type: K8sRollingDeploy
                  timeout: 10m
                  spec:
                    skipDryRun: false
                    pruningEnabled: false
            rollbackSteps:
              - step:
                  name: Rollback Rollout Deployment
                  identifier: rollbackRolloutDeployment
                  type: K8sRollingRollback
                  timeout: 10m
                  spec:
                    pruningEnabled: false
        tags: {}
        failureStrategies:
          - onFailure:
              errors:
                - AllErrors
              action:
                type: StageRollback

```

- Then as we can see, we got an error in "BuildAndPushECR" step of "Build" stage.
  ![Build Screenshot](https://raw.githubusercontent.com/vivekraj601/Harness/harness-AI/media/build.png)

