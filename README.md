# Objective

The objective of this app is to show how to bootstrap a VM without containers, using a GitHub Actions CI/CD Pipeline and Terraform

# Summary
The application simply serves hello world on the index route and the testing piece of the pipeline only tests that route in the Flask app
This app is written in python because that is the simplest way I knew how to rig up a simple server app
The terraform code generally makes use of Google's Terraform Registry modules to simplify rigging up the common components
Most of the GitHub Actions code also makes use of common Actions for doing common things like configuring terraform and gcloud
There is a custom network that opens port 22 (ssh, which is only for help debugging, and should be disabled) and 8080 (the app's port)
The custom network also has a Cloud NAT and router for public internet access, so if we had a load balancer we could and should remove the public ip address of the instance


# Development

First use local backend in infrastructure/meta to create state infrastructure for terraform in infrastructure/maan
The GitHub repo has a TF_VAR_project_id and a GCP_KEY with credentials for authenticating, need to provide those locally for local development


# Backlog
I ran out of time but here are some additional things I would focus on:
* Instead of GPC_KEY, use workload identity (much better security practice, keys are bad) with GitHub Actions
* Version the application
* Use a load balancer and add HA with multiple instances and a static IP address and TLS
* Remove public IP of instance
* Force signed commits in the repo
* Least privileges the IAM roles
* The deploy step should depend upon the test step in the Actions
* Tracing/ observability

# Challenges
Relearning some GCP concepts, starting up my personal GCP organization
Using virtual machines without containers is an unpleasant experience that I do not miss
I overengineered the networking component and should have just used the default network structures in the project.  This added unnecessary complexity and wasted time