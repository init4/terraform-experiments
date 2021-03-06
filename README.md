# Terraform experiments with: AWS / Azure / VMware & F5 

![Dinobots image](https://github.com/init4/terraform-experiments/blob/master/html/dinobots.jpg?raw=true)

## Goal: try out a number of Terraform scenarios in public/private cloud and with F5 traffic management 

#### Use case 1: [AWS servers](https://github.com/init4/terraform-experiments/tree/master/dinobots) 
Simple use case that deploys a number of Amazon Linux instances in us-east-2. Working 100%

#### Use case 2: [AWS servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/tree/master/dinobots_with-f5/) 
Simple use case that deploys a number of Amazon Linux instances in us-east-2, with TMOS 15.1 reverse proxy, Working 100%.

#### Use case 3: [Azure servers](https://github.com/init4/terraform-experiments/tree/master/constructicons/) 
Initial prototype complete.

#### Use case 4: [Azure servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/tree/master/constructicons_with-f5/)
Not started

#### Use case 5: [VMware servers](https://github.com/init4/terraform-experiments/tree/master/combaticons/)
Not started

#### Use case 6: [VMware servers and F5 reverse proxy](https://github.com/init4/terraform-experiments/tree/master/combaticons_with-f5/)
Not started

## Todo 
- Incorporate DNS; either normal dynamic DNS or F5 Cloud Services
- Finish the other initial Terraform configs 
- Expand all use cases to include Web Application Firewall, DDoS protection, etc, configs. 

## References
These docs were helpful:
- https://clouddocs.f5.com 
- [@F5Networks](https://github.com/F5Networks/terraform-provider-bigip)
- [@hooklift](https://github.com/hooklift/terraform-provider-vix)
 
