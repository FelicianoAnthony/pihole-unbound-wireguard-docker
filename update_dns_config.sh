#!/bin/bash

: '
when a new EC2 instance is created, port 53 is in use. 
port 53 is required by pihole.
this script stops process from listening on port 53 after a reboot.
'

update_dns_config() {
    local file_path="$1"
    local dns_ip="$2"
    local dns_pattern="#DNS="
    local dns_stub_listener_pattern="#DNSStubListener=yes"

    # Check if both DNS patterns exist in the file
    if grep -q "^$dns_pattern" "$file_path" && grep -q "^$dns_stub_listener_pattern" "$file_path"; then
        # Replace the DNS line
        sudo sed -i "s|^$dns_pattern|DNS=$dns_ip|" "$file_path"
        
        # Replace the DNSStubListener line
        sudo sed -i "s|^$dns_stub_listener_pattern|DNSStubListener=no|" "$file_path"
    else
        echo "Error: One or both DNS configurations not found in $file_path. Aborting."
        exit 1
    fi
}

# https://unix.stackexchange.com/questions/676942/free-up-port-53-on-ubuntu-so-costom-dns-server-can-use-it
config_file="/etc/systemd/resolved.conf"
dns_ip="1.1.1.1"
update_dns_config "$config_file" "$dns_ip"
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf


# the following behavior seems harmless. after this script is run, sometimes there are errors after running commands that dont seem to impact anything
    # sudo: unable to resolve host ip-<Private IP DNS name (IPv4 only)>: Name or service not known
        # https://stackoverflow.com/questions/33441873/aws-error-sudo-unable-to-resolve-host-ip-10-0-xx-xx
