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

2. Run command to apply the file you downloaded
   ```bash
      helm install gitops-agent ./gitops-agent.tgz --namespace harness-gitops --create-namespace
   ```
For CD Pipeline, we first need to install the Harness Delegate. </br>
Harness Delegate is a service that can run in local network or VPC to connect artifact servers, infrastructure, collaboration, verification and other providers, with the Harness Manager. Harness provides different types of Delegates to give you flexibility in how you manage deployments. You can either deploy a kubernetes based delegate or a docker based delegate. 
Following are the steps: </br>
1. Either you can [download](./harness-delegate.yml) the YAML manifest or Copy the YAML to a machine with kubectl installed and with access to your Kubernetes cluster.
   ```yml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: harness-delegate-ng
      
      ---
      
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: harness-delegate-ng-cluster-admin
      subjects:
        - kind: ServiceAccount
          name: default
          namespace: harness-delegate-ng
      roleRef:
        kind: ClusterRole
        name: cluster-admin
        apiGroup: rbac.authorization.k8s.io
      
      ---
      
      apiVersion: v1
      kind: Secret
      metadata:
        name: kubernetes-delegate-account-token
        namespace: harness-delegate-ng
      type: Opaque
      data:
        DELEGATE_TOKEN: "Y2Q4MzlkZmYxN2IyM2VmNGRkNTllYmFiOTQ0YmZlN2U="
      
      ---
      
      # If delegate needs to use a proxy, please follow instructions available in the documentation
      # https://ngdocs.harness.io/article/5ww21ewdt8-configure-delegate-proxy-settings
      
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        labels:
          harness.io/name: kubernetes-delegate
        name: kubernetes-delegate
        namespace: harness-delegate-ng
      spec:
        replicas: 1
        minReadySeconds: 120
        selector:
          matchLabels:
            harness.io/name: kubernetes-delegate
        template:
          metadata:
            labels:
              harness.io/name: kubernetes-delegate
            annotations:
              prometheus.io/scrape: "true"
              prometheus.io/port: "3460"
              prometheus.io/path: "/api/metrics"
          spec:
            terminationGracePeriodSeconds: 3600
            restartPolicy: Always
            containers:
            - image: harness/delegate:25.01.85000
              imagePullPolicy: Always
              name: delegate
              securityContext:
                allowPrivilegeEscalation: false
                runAsUser: 0
              ports:
                - containerPort: 8080
              resources:
                limits:
                  memory: "2048Mi"
                requests:
                  cpu: "0.5"
                  memory: "2048Mi"
              livenessProbe:
                httpGet:
                  path: /api/health
                  port: 3460
                  scheme: HTTP
                initialDelaySeconds: 10
                periodSeconds: 10
                failureThreshold: 3
              startupProbe:
                httpGet:
                  path: /api/health
                  port: 3460
                  scheme: HTTP
                initialDelaySeconds: 30
                periodSeconds: 10
                failureThreshold: 15
              envFrom:
              - secretRef:
                  name: kubernetes-delegate-account-token
              env:
              - name: JAVA_OPTS
                value: "-Xms64M"
              - name: ACCOUNT_ID
                value: ILu7YnmpSvC7XE1cdJBmaQ
              - name: MANAGER_HOST_AND_PORT
                value: https://app.harness.io
              - name: DEPLOY_MODE
                value: KUBERNETES
              - name: DELEGATE_NAME
                value: kubernetes-delegate
              - name: DELEGATE_TYPE
                value: "KUBERNETES"
              - name: DELEGATE_NAMESPACE
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.namespace
              - name: INIT_SCRIPT
                value: ""
              - name: DELEGATE_DESCRIPTION
                value: ""
              - name: DELEGATE_TAGS
                value: ""
              - name: NEXT_GEN
                value: "true"
              - name: CLIENT_TOOLS_DOWNLOAD_DISABLED
                value: "true"
              - name: DELEGATE_RESOURCE_THRESHOLD
                value: ""
              - name: DYNAMIC_REQUEST_HANDLING
                value: "false"
      
      ---
      
      apiVersion: autoscaling/v2
      kind: HorizontalPodAutoscaler
      metadata:
         name: kubernetes-delegate-hpa
         namespace: harness-delegate-ng
         labels:
             harness.io/name: kubernetes-delegate
      spec:
        scaleTargetRef:
          apiVersion: apps/v1
          kind: Deployment
          name: kubernetes-delegate
        minReplicas: 1
        maxReplicas: 1
        metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              type: Utilization
              averageUtilization: 70
        - type: Resource
          resource:
            name: memory
            target:
              type: Utilization
              averageUtilization: 70
      
      ---
      
      kind: Role
      apiVersion: rbac.authorization.k8s.io/v1
      metadata:
        name: upgrader-cronjob
        namespace: harness-delegate-ng
      rules:
        - apiGroups: ["batch", "apps", "extensions"]
          resources: ["cronjobs"]
          verbs: ["get", "list", "watch", "update", "patch"]
        - apiGroups: ["extensions", "apps"]
          resources: ["deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch"]
      
      ---
      
      kind: RoleBinding
      apiVersion: rbac.authorization.k8s.io/v1
      metadata:
        name: kubernetes-delegate-upgrader-cronjob
        namespace: harness-delegate-ng
      subjects:
        - kind: ServiceAccount
          name: upgrader-cronjob-sa
          namespace: harness-delegate-ng
      roleRef:
        kind: Role
        name: upgrader-cronjob
        apiGroup: ""
      
      ---
      
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: upgrader-cronjob-sa
        namespace: harness-delegate-ng
      
      ---
      
      apiVersion: v1
      kind: Secret
      metadata:
        name: kubernetes-delegate-upgrader-token
        namespace: harness-delegate-ng
      type: Opaque
            data:
              UPGRADER_TOKEN: "Y2Q4MzlkZmYxN2IyM2VmNGRkNTllYmFiOTQ0YmZlN2U="
        
        ---
        
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kubernetes-delegate-upgrader-config
          namespace: harness-delegate-ng
        data:
          config.yaml: |
            mode: Delegate
            dryRun: false
            workloadName: kubernetes-delegate
            namespace: harness-delegate-ng
            containerName: delegate
            delegateConfig:
              accountId: ILu7YnmpSvC7XE1cdJBmaQ
              managerHost: https://app.harness.io
        
        ---
        
        apiVersion: batch/v1
        kind: CronJob
        metadata:
          labels:
            harness.io/name: kubernetes-delegate-upgrader-job
          name: kubernetes-delegate-upgrader-job
          namespace: harness-delegate-ng
        spec:
          schedule: "0 */1 * * *"
          concurrencyPolicy: Forbid
          startingDeadlineSeconds: 20
          jobTemplate:
            spec:
              template:
                spec:
                  serviceAccountName: upgrader-cronjob-sa
                  restartPolicy: Never
                  containers:
                  - image: harness/upgrader:latest
                    name: upgrader
                    imagePullPolicy: Always
                    envFrom:
                    - secretRef:
                        name: kubernetes-delegate-upgrader-token
                    volumeMounts:
                      - name: config-volume
                        mountPath: /etc/config
                  volumes:
                    - name: config-volume
                      configMap:
                        name: kubernetes-delegate-upgrader-config

   ```

2. Apply Harness Delegate
    ```bash
       kubectl apply -f harness-delegate.yml
   ```
