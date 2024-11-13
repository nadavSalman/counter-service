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
Provisioning Infrastructure 
- [ ] Create EKS using Terraform











---


--

## Why do AWS recommend public and private subnets with a nat gateway?


--

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
        - Scale cluster compute : Cluster Autoscaler















