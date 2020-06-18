# FIXME 
# - Due to terraform issue #2430 there is no way to set a provider dependency this means that
#   we cannot simply use the output of an ec2 deployment as a provider input 
# - https://github.com/hashicorp/terraform/issues/2430 
# - https://github.com/terraform-providers/terraform-provider-bigip/issues/236 
 
provider "bigip" {
  #address  = "${aws_instance.bigip1.public_ip}"
  address  = "3.21.232.120"
  username = "admin"
  password = "p4ssw0rd"
}

resource "bigip_ltm_irule" "i_app1-http-router" {
  name = "/Common/i_app1-http-router"
  irule = file("i_app1-http-router.tcl")
}

resource "bigip_ltm_monitor" "mon_app1-http" {
  name     = "/Common/mon_app1-http"
  parent   = "/Common/http"
  send     = "GET /\r\n"
  timeout  = "16"
  interval = "5"
}

resource "bigip_ltm_node" "slag" {
  name    = "/Common/slag"
  address = aws_instance.slag.private_ip 
}

resource "bigip_ltm_node" "sludge" {
  name    = "/Common/sludge"
  address = aws_instance.sludge.private_ip 
}

resource "bigip_ltm_node" "snarl" {
  name    = "/Common/snarl"
  address = aws_instance.snarl.private_ip 
}

resource "bigip_ltm_node" "swoop" {
  name    = "/Common/swoop"
  address = aws_instance.swoop.private_ip 
}

resource "bigip_ltm_pool" "p_app1-http" {
  name                = "/Common/p_app1-http"
  load_balancing_mode = "round-robin"
  monitors            = ["/Common/mon_app1-http"]
  allow_snat          = "yes"
  allow_nat           = "yes"
  depends_on = [bigip_ltm_monitor.mon_app1-http]
}

resource "bigip_ltm_pool_attachment" "attach_slag" {
  pool       = bigip_ltm_pool.p_app1-http.name
  node       = "/Common/slag:80"
  depends_on = [bigip_ltm_pool.p_app1-http]
}

resource "bigip_ltm_pool_attachment" "attach_sludge" {
  pool       = bigip_ltm_pool.p_app1-http.name
  node       = "/Common/sludge:80"
  depends_on = [bigip_ltm_pool.p_app1-http]
}

resource "bigip_ltm_pool_attachment" "attach_snarl" {
  pool       = bigip_ltm_pool.p_app1-http.name
  node       = "/Common/snarl:80"
  depends_on = [bigip_ltm_pool.p_app1-http]
}

resource "bigip_ltm_pool_attachment" "attach_swoop" {
  pool       = bigip_ltm_pool.p_app1-http.name
  node       = "/Common/swoop:80"
  depends_on = [bigip_ltm_pool.p_app1-http]
}

resource "bigip_ltm_virtual_server" "vs_app1-http" {
  pool       = bigip_ltm_pool.p_app1-http.name
  name = "/Common/vs_app1-http"
  destination = "10.0.1.100"
  ip_protocol = "tcp"
  port = 80
  source_address_translation = "automap"
  profiles = ["/Common/http","/Common/f5-tcp-progressive"]
  irules = ["${bigip_ltm_irule.i_app1-http-router.name}"]
  depends_on = [bigip_ltm_pool.p_app1-http]
}

