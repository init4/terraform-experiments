# Terraform experiments with: AWS / Azure / F5 TMOS / VMWare Fusion 

## Goal: try out a number of Terraform scenarios in public/private cloud and with F5 traffic management 
#### Use case 1: [AWS servers](https://github.com/init4/terraform-experiments/dinobots/) 
Simple use case that deploys a number of Amazon Linux instances in us-east-2. Working 100%

#### Use case 2: [AWS servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/dinobots_with-f5/) 
Simple use case that deploys a number of Amazon Linux instances in us-east-2, with TMOS 15.1 reverse proxy, Working 100%.

#### Use case 3: [Azure servers](https://github.com/init4/terraform-experiments/constructicons/) 
Not started

#### Use case 4: [Azure servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/constructicons_with-f5/)
Not started

#### Use case 5: [VMware servers](https://github.com/init4/terraform-experiments/combaticons/)
Not started

#### Use case 6: [VMware servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/combaticons_with-f5/)
Not started

## Todo 
- Finish the other initial Terraform configs 
- Expand all use cases to include Web Application Firewall, DDoS protection, etc, configs. 

## References
These docs were helpful:
- (https://clouddocs.f5.com) 
- [@F5Networks](https://github.com/F5Networks/terraform-provider-bigip)
 
