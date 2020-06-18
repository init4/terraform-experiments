when CLIENT_ACCEPTED {
  if { [IP::protocol] == 6 } {
    log local0. "src [IP::remote_addr]:[TCP::remote_port] -> dst [IP::local_addr]:[TCP::local_port]"
  }  
}
when HTTP_REQUEST {
    set xff [IP::remote_addr]
    HTTP::header insert X-Forwarded-For: $xff
    if { [string tolower [HTTP::uri]] eq "/bots.html" } {
        set html "<html><title>\[ f5 / terraform demo \]</title><body><center><h1>\[ f5 / terraform demo \]</h1><p>"
        append html "virtual service: [IP::local_addr]:[TCP::local_port]<br>"
        append html "x-forwarded-for: $xff </p><table>"
        append html "<td>node1:<br><iframe src=\"/?slag\" style=\"width: 400px; height: 350px; \"></iframe>"
        append html "<br>node3:<br><iframe src=\"/?sludge\" style=\"width: 400px; height: 350px; \"></iframe></td>"
        append html "<td>node2:<br><iframe src=\"/?snarl\" style=\"width: 400px; height: 350px; \"></iframe>"
        append html "<br>node4:<br><iframe src=\"/?swoop\" style=\"width: 400px; height: 350px; \"></iframe></td>"
        append html "</table></center></body></html>"
        HTTP::respond 200 content $html
    }
    if { [HTTP::query] contains "slag" } {
        node 10.0.2.101:80
    }
    if { [HTTP::query] contains "sludge" } {
        HTTP::path /
        node 10.0.2.102:80
    }
    if { [HTTP::query] contains "snarl" } {
        HTTP::path /
        node 10.0.2.103:80
    }
    if { [HTTP::query] contains "swoop" } {
        HTTP::path /
        node 10.0.2.104:80
    }
    log local0. "[HTTP::host] uri [HTTP::uri]"
}
