## Generate PR summaries with AIDA

Harness AIDA (AI Development Assistant) can automatically generate Pull Request (PR) summaries, saving developers time and ensuring clarity in code reviews.

🔹 Key Features of AIDA PR Summaries: </br>
✅ Automated Summary Generation – AIDA scans code changes and generates a concise, structured PR description. </br>
✅ Highlights Key Modifications – Summarizes added, modified, and deleted files/functions. </br>
✅ Improves Code Reviews – Provides clear context for reviewers without manually writing summaries. </br>
✅ Enhances Collaboration – Ensures PRs have consistent, well-documented descriptions. </br>
✅ Supports Large PRs – Handles multi-file and complex changes efficiently. </br>

Automatic pull request summaries enhance the collaborative development process by automatically generating comprehensive and informative summaries for pull requests within version control systems. This automation leverages predefined templates or AI-driven analysis of code changes to succinctly describe what the pull request comprises, including:
- The purpose of the changes.
- The issues it addresses.
- Potential impacts on the existing codebase. </br>

By providing a clear and detailed context right from the start, automatic pull request descriptions facilitate quicker and more effective review processes. Reviewers can easily understand the intent and scope of the changes without needing to delve deeply into the code itself. </br>

### Example:
- Let say I made some changes on a branch other than "main" and now i want to create a Pull Request to merge those changes ontot he main branch. Suppose this is the deployment.yaml file for an application named my-app I've added using a new branch:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app-container
          image: my-app-image:latest  # Replace with your actual image
          ports:
            - containerPort: 80
          env:
            - name: ENVIRONMENT
              value: "production"
          resources:
            requests:
              cpu: "250m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
      restartPolicy: Always
```
- Now when we create a PR, we can see there Hanress AIDA option which will generate PR summary. </br>

![searcho-code](https://github.com/vivekraj601/Harness/blob/8338dacecd2d32816f660373f566cc49e0e63ba0/harness-AI/media/PR.png)
  </br>
  </br>
![searcho-code](https://github.com/vivekraj601/Harness/blob/4738f0f01a5548d543b2b6695927ab9176d9acc1/harness-AI/media/pr3.png)
