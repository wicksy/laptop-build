#!/bin/bash
#
# Create /etc/network/interfaces.d/ file for wifi interface to get onto network
# to allow bootstrap to be run and utlimately a Salt highstate to configure
# everything else
#
echo "Enter SSID:"
read ssid
echo "Enter passphrase:"
read passphrase
key=$(/usr/bin/wpa_passphrase "${ssid}" "${passphrase}" \
        | /usr/bin/tr -d ' \t' \
        | /usr/bin/awk -F'=' '$1 == "psk" {print $2}')

cat > /etc/network/interfaces.d/wlp9s0 <<EOF
# Wireless interface
auto wlp9s0
iface wlp9s0 inet dhcp
  wpa-ssid ${ssid}
  wpa-psk ${key}
EOF

/bin/chmod 600 /etc/network/interfaces /etc/network/interfaces.d/*
