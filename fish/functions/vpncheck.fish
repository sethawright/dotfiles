function vpncheck --description 'Print VPN, Tailscale, DNS, and route state for debugging'
    echo "=== $(date) ==="
    echo "--- default route"
    route -n get default 2>&1 | grep -E 'gateway|interface'
    echo "--- routes on tunnels"
    netstat -rn -f inet | grep -E '^default|utun|^0/1|^128.0/1'
    echo "--- wireguard"
    sudo wg show 2>&1 | grep -E 'interface|endpoint|handshake|transfer'
    echo "--- manual DNS in System Settings"
    for svc in Wi-Fi "USB 10/100/1000 LAN" "Thunderbolt Bridge" "iPhone USB"
        printf "%s: " $svc
        networksetup -getdnsservers $svc | tr '\n' ' '
        echo
    end
    echo "--- DHCP DNS on en0"
    ipconfig getpacket en0 2>/dev/null | grep -E 'domain_name_server|router'
    echo "--- system resolver"
    scutil --dns | sed -n '3,8p'
    echo "--- tailscale"
    tailscale status --peers=false 2>&1 | head -1
    tailscale dns status 2>&1 | sed -n '/^Nameservers/,/^$/p'
    echo "--- tests"
    ping -c 1 -t 3 192.168.12.1 2>&1 | tail -1
    ping -c 1 -t 3 1.1.1.1 2>&1 | tail -1
    echo "dig via system: $(dig +short +time=3 +tries=1 google.com | head -1)"
    echo "dig via 1.1.1.1: $(dig +short +time=3 +tries=1 @1.1.1.1 google.com | head -1)"
    curl -s -m 5 -o /dev/null -w "curl https: %{http_code} %{time_total}s\n" https://www.google.com
    ping -c 1 -t 3 192.168.3.1 2>&1 | tail -1
end
