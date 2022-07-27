$TTL    604800
@       IN      SOA     ns1.caio-foundation.com. root.caio-foundation.com. (
                  3       ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
; name servers - NS records
     IN      NS      ns1.caio-foundation.com.

; name servers - A records
ns1.caio-foundation.com.          IN      A      192.168.10.2

host1.caio-foundation.com.        IN      A      192.168.10.4
host2.caio-foundation.com.        IN      A      192.168.10.5