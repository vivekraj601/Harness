# Harness AIDA Cloud Cost Optimization
This is a tool designed to help organizations monitor, analyze, and reduce cloud spending across various cloud providers such as AWS, GCP, and Azure. It provides real-time insights, cost forecasting, anomaly detection, and automated governance to optimize resource utilization.

### Key Features:
- Anomaly Detection – Identifies unusual spikes in cloud costs using AI/ML.
- Auto-Stopping – Automatically shuts down idle cloud resources to reduce waste.
- Budgeting & Forecasting – Predicts future cloud costs and helps enforce budget limits.
- Multi-Cloud Support – Works across AWS, GCP, and Azure to provide a unified cost view.


### Intelligent Auto-Stopping:
Uses AI to analyze usage patterns and automatically shut down idle VMs, containers, and databases when not in use.
Adapts schedules dynamically based on actual workload behavior.
Prevents zombie instances from running in the background (resources left running accidentally). </br>
From this dashboard itself we can turn on any stopped instance and also check history of that particular instance. We can specify rules such as if an instance is idle for 5 mins, turn it off and if any traffic is detected on the stopped instance, autostopping will automatically start that instance again, ensuring no workflow interruptions. 
**Using this we can save upto 75% on our non-production cloud environments.

![CCM](https://github.com/vivekraj601/Harness/blob/2fdee269c6fee957975755cfbc66e4f2d24032bc/harness-AI/media/ccm1.png)

![CCM2](https://github.com/vivekraj601/Harness/blob/2fdee269c6fee957975755cfbc66e4f2d24032bc/harness-AI/media/ccm2.png)

### Harness AIDA offers comprehensive support with the following functionalities:

- Assist with writing rules: Harness AIDA helps you formulate rules tailored to your specific requirements. It understands your requirements and generates customized rules to align with your governance objectives.
- Describe existing rules: Harness AIDA offers detailed descriptions of built-in rules. This feature enables you to understand the purpose, scope, and implications of each rule, thereby facilitating informed decision-making during the policy creation process.

![CCM2](https://github.com/vivekraj601/Harness/blob/432059ba5e68b96b5f1e0a04888a059359caa470/harness-AI/media/ccm3.png)

![CCM2](https://github.com/vivekraj601/Harness/blob/432059ba5e68b96b5f1e0a04888a059359caa470/harness-AI/media/ccm4.png)
