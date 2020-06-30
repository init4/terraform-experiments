#### Use case 2: AWS servers and F5 reverse proxy

For the inital provisioning run, make sure the app1.tf and app2.tf are both renamed aside. This is because the provider dependencies cannot be satisfied until the AWS instances are built and IP addresses have been assigned.

Ensure you define the AWS credentials and path to AWS SSH public key in aws.tf.

Then run:
- terraform init
- terraform plan 
- terraform apply

[![asciicast](https://asciinema.org/a/tExc9HAhfVhDK34e5yFY812u4.svg)](https://asciinema.org/a/tExc9HAhfVhDK34e5yFY812u4)

Once all the servers and bigip have been provisioned there are two options for building application configs:
1. app1.tf
2. app2.tf

The app1.tf option builds all of the bigip configs using the normal F5 iControl REST API. This is an interative approach and all config elements must be defined in the HCL file.

Before running terraform again, edit app1.tf to provide bigip IP address and admin credentials.

[![asciicast](https://asciinema.org/a/RwfAcCsQ70k36QWhMMF0b7pxq.svg)](https://asciinema.org/a/RwfAcCsQ70k36QWhMMF0b7pxq)

Alternatively, app2.tf uses the AS3 extension to declaritively define the bigip configs. This is a better option as AS3 will find and resolve config dependencies which may be tedious if you arent familar with bigip config.

Again, edit app2.tf to provide bigip IP address and admin credentials.

[![asciicast](https://asciinema.org/a/fcPDmaw3D2E8D4iv6tBHKIXaF.svg)](https://asciinema.org/a/fcPDmaw3D2E8D4iv6tBHKIXaF)

