# counter-service
This is a simple web server which counts the amount of POST requests it served, and return it on every GET request it gets


## Assignment requirements:
Your mission, should you choose to accept it, is the development and deployment of a Nano service.

Please read the following instructions before starting to implement your mission, you don't want to miss any important instruction, especially those in General Guidelines, please let me know if you have any questions by Email/Phone/Whatsapp.


Ill provide you an AWS account.

* Env
Install Kubernetes - Have a minimal Kubernetes deployed as code (terraform preferred) in the cloud account.

* Python service
Fork the following repo https://github.com/shainberg/counter-service

This repo contains a simple web page that counts the number of POST requests it served, and returns the counter on every GET request it gets.

Bonus: You can improve the code if you would like to.



* Docker
Create a Docker file for the counter-service, and publish it to Docker registry. Make sure your Docker image is slim.

Bonus: Consider what will happen if the image is restarted? If the counter is persistent you get a bonus


* Deployment
Using a CI/CD service - Create a CI Pipeline for the service it should build the image and upload it to image repo. The Pipeline should be as code.

CD - Upon commit & push to the main (aka master) branch, code should pass CI/CD and be deployed on the "prod" ns. for example: changing something on the git, commit & push, the get web page should change.

Bonus: Have HA for the micro service, and make sure it can scale out


* General Guidelines
Spend some time on designing your solution.
Think about operational use cases from the real world. What happens if a service crashes?
What happens when this service needs to scale? How will it be done?


Deliverables
The url to your "counter-service", on port 80.
Send to me an SCM Merge / pull Request for code review - from your branch to master, containing all of the code for this exercise. The Merge-Request should contain a short description of your changes, and any other comment you’d like us to know of.

---

### Action Items


* Provisioning Infrastructure 
    - [x] Create EKS using Terraform
    - [x] Test cluster acess
    - [x] Nginx ingress Contoller
 
* Counter Service
    - [x] Improve code
    - [x] Dockerise
    - [x] Wratp with Helm
    - [x] Local Deploymetn test 

* CI/CD infra
    - [x] CI - Continer build & publish
    - [x] CD - Deploy to via Helm to EKS 



---

<br/>
<br/>
<br/>


Deployment Architecture :
![alt text](images/image_01.png)


<br/>
<br/>
<br/>

Terraform Architecture
![alt text](images/image_02.png)



---









---
### Export kubeconifg
```bash
aws eks update-kubeconfig --region eu-west-2 --name infinity
```
---
## Deploymetn on Kind Cluster
pv,pvc : `cluster-provisioning/rancher.io-local-path/demo`

### Test local storage (rancher.io/local-path )

```bash
on kind-kind counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ k get pods,pvc,pv,sc  -n prod 
NAME              READY   STATUS    RESTARTS   AGE
pod/volume-test   1/1     Running   0          60s

NAME                                   STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/local-path-pvc   Bound    pvc-d87d642a-cd53-4dda-ac4b-6081f0405579   128Mi      RWO            local-path     <unset>                 4d15h

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/pvc-d87d642a-cd53-4dda-ac4b-6081f0405579   128Mi      RWO            Delete           Bound    prod/local-path-pvc   local-path     <unset>                          4d15h

NAME                                             PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/local-path           rancher.io/local-path   Delete          WaitForFirstConsumer   false                  4d16h
storageclass.storage.k8s.io/standard (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  6d16h

on kind-kind counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
```


### Persistent storage
![alt text](images/image_05.png)


### Counter Service Demo :
<br/>
<br/>
Service ir runnig :

```bash
counter-service on  dev [✘?] via 🐍 v3.12.3 (venv) 
❯ k logs counter-service-infinity-service-6746799879-vbpd5 -n prod 
Successfully wrote value 0 to counter file /data/counter.txt
Successfully read counter file /data/counter.txt
 * Serving Flask app 'app.py'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://10.244.0.42:5000
Press CTRL+C to quit
10.244.0.1 - - [26/Nov/2024 12:07:31] "GET / HTTP/1.1" 200 -
10.244.0.1 - - [26/Nov/2024 12:07:31] "GET / HTTP/1.1" 200 -

counter-service on  dev [✘?] via 🐍 v3.12.3 (venv) 
❯ k get pvc,pv -n prod 
NAME                                   STATUS   VOLUME          CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/local-path-pvc   Bound    local-path-pv   128Mi      RWO            local-path     <unset>                 55s

NAME                             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/local-path-pv   128Mi      RWO            Retain           Bound    prod/local-path-pvc   local-path     <unset>                          63s

counter-service on  dev [✘?] via 🐍 v3.12.3 (venv) 
❯
```
<br/>
<br/>

### Test persistent counter after pods are down :

```bash
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ k get ing -n prod 
NAME                               CLASS   HOSTS             ADDRESS     PORTS   AGE
counter-service-infinity-service   nginx   counter-service   localhost   80      8m45s

counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ curl counter-service/
Our counter is: 0 
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ for i in {1..3}; do curl -X POST http://counter-service/; done
Hmm, Plus 1 please Hmm, Plus 1 please Hmm, Plus 1 please 
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ curl counter-service/
Our counter is: 3 
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ 
```

<br/>
<br/>

### Set replicas to 0 and then scale back to 1.

```bash
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ helm upgrade --install counter-service k8s-deployment/infinity-service/   --values counter-service/deployment/values.yaml   --set image.tag="sha-f6caf4a" --set replicaCount=0   -n prod   --create-namespace &&  helm upgrade --install counter-service k8s-deployment/infinity-service/   --values counter-service/deployment/values.yaml   --set image.tag="sha-f6caf4a" --set r
eplicaCount=1   -n prod   --create-namespace
Release "counter-service" has been upgraded. Happy Helming!
NAME: counter-service
LAST DEPLOYED: Tue Nov 26 14:14:38 2024
NAMESPACE: prod
STATUS: deployed
REVISION: 2
NOTES:
1. Get the application URL by running these commands:
  http://counter-service/
Release "counter-service" has been upgraded. Happy Helming!
NAME: counter-service
LAST DEPLOYED: Tue Nov 26 14:14:39 2024
NAMESPACE: prod
STATUS: deployed
REVISION: 3
NOTES:
1. Get the application URL by running these commands:
  http://counter-service/

counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ k get pods -n prod 
NAME                                                READY   STATUS        RESTARTS   AGE
counter-service-infinity-service-6746799879-pxvjp   1/1     Running       0          5s
counter-service-infinity-service-6746799879-vbpd5   1/1     Terminating   0          7m25s

...

counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ k get pods -n prod 
NAME                                                READY   STATUS    RESTARTS   AGE
counter-service-infinity-service-6746799879-pxvjp   1/1     Running   0          44s


# Counter saved state 🥳🥳🥳 !!!
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ curl counter-service/
Our counter is: 3 
counter-service on  dev [✘!?] via 🐍 v3.12.3 (venv) 
❯ 
```






<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>









---

### EKS Persistent storage for Maintaining County State 


EFS
```bash
~ on ☁️  (eu-west-2) took 4s
❯ aws efs describe-file-systems --query "FileSystems[*].[FileSystemId,Name,CreationTime,NumberOfMountTargets]" --output table
--------------------------------------------------------------------
|                        DescribeFileSystems                       |
+-----------------------+-------+-----------------------------+----+
|  fs-04c766103518e0935 |  None |  2024-11-15T00:42:33+02:00  |  2 |
+-----------------------+-------+-----------------------------+----+

~ on ☁️  (eu-west-2) took 6s
❯
```

Install EFS CSI Driver :
```
helm upgrade --install aws-efs-csi-driver --namespace kube-system aws-efs-csi-driver/aws-efs-csi-driver
```


SC,PV,PVC
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-sc
provisioner: efs.csi.aws.comapiVersion: v1

---

kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  storageClassName: efs-sc
  persistentVolumeReclaimPolicy: Retain
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-04c766103518e0935apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: efs-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: efs-sc
  resources:
    requests:
      storage: 5Gi

---

kind: PersistentVolume
metadata:
  name: efs-pv
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  storageClassName: efs-sc
  persistentVolumeReclaimPolicy: Retain
  csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-04c766103518e0935apiVersion: v1


kind: PersistentVolumeClaim
metadata:
  name: efs-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: efs-sc
  resources:
    requests:
      storage: 5Gi
```


```bash
❯ k get sc,pv,pvc
NAME                                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/efs-sc   efs.csi.aws.com         Delete          Immediate              false                  14m
storageclass.storage.k8s.io/gp2      kubernetes.io/aws-ebs   Delete          WaitForFirstConsumer   false                  29m

NAME                      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/efs-pv   5Gi        RWO            Retain           Bound    default/efs-claim   efs-sc         <unset>                          14m

NAME                              STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/efs-claim   Bound    efs-pv   5Gi        RWO            efs-sc         <unset>                 14m
```


Test :

```yaml
kind: Pod
metadata:
  name: efs-app
spec:
  containers:
  - name: app
    image: centos
    command: ["/bin/sh"]
    args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
    volumeMounts:
    - name: persistent-storage
      mountPath: /data
  volumes:
  - name: persistent-storage
    persistentVolumeClaim:
      claimName: efs-claimapiVersion: v1
```


```bash
counter-service/cluster-provisioning/terraform on  dev [✘!?] via 💠 default on ☁️  (eu-west-2) 
❯ kubectl exec -ti efs-app -- tail -f /data/out.txt
Thu Nov 14 23:20:18 UTC 2024
Thu Nov 14 23:20:23 UTC 2024
Thu Nov 14 23:20:28 UTC 2024
Thu Nov 14 23:20:33 UTC 2024
Thu Nov 14 23:20:38 UTC 2024
Thu Nov 14 23:20:43 UTC 2024
Thu Nov 14 23:20:48 UTC 2024
Thu Nov 14 23:20:53 UTC 2024
Thu Nov 14 23:20:58 UTC 2024
Thu Nov 14 23:21:03 UTC 2024
Thu Nov 14 23:21:08 UTC 2024
```

--
### Counter file local continer test 


![alt text](images/image_03.png)
--
### GitHub action CI/CD
![alt text](images/image_04.png)



```
❯ helm get manifest counter-service -n prod  | grep kind: 
kind: ServiceAccount
kind: PersistentVolume
kind: PersistentVolumeClaim
kind: Service
kind: Deployment
kind: HorizontalPodAutoscaler
    kind: Deployment
kind: Ingress
kind: Pod

```


### Addressing General Guidelines

* operational use cases from the real, service crashes
    - Configure Kubernetes to automatically restart a failed service
    - Liveness and Readiness probes
        - Livens:
            1. Check http service is up and runnig by sending GET req to getll endpoints
            2. Validate the "cash" file mount from pv. Check the counter value >= 0.
        - Readiness
            1. Use http prob declerative to check reponse for the main get counter value endpoint to be 200 ok.
    - Rollback : canary deployment or blue-green deployment
    - Crash Analysis and Monitoring :  P -1
    - Resource Management and Scaling
        - Resource Limit 
        - HPA
        - Scale cluster compute : Cluster Autoscaler (Not implemented yet ...)













