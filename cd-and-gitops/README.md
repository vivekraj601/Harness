# Modern Continuous Delivery (CD) and GitOps
- Cloud native deployment without scripting.
- Intelligent deployment verification powered by AI.
- Use Canary, Blue Green or Rolling Deployment and No scripting required.

### Let say we want to deploy an Nginx-app, so these are the steps we follow:
- First we select the type of Workload and k8s configuration.
  ![App Screenshot](C:\Users\vr322\OneDrive\Desktop\Harness POC\1.png)
- Then we specify how do we want to deploy, whether using CD GitOps or CD pipeline. For both of these cases, we need to connect Harness to our cluster. </br>
For CD GitOps, these are the steps:
1. Download Helm Chart for GitOps Agent and Argo CD. </br>
   [Download GitOps Agent](./gitops-agent.tgz)
