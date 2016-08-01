#!/bin/bash
#
# Setup wifi interface to get onto a network to allow a bootstrap to be downloaed
# and run to configure everything (currently using Salt or Ansible). Initially
# supporting only Ubuntu but to be extended later to other distros.
#

# Setup wifi on Ubuntu (create a /etc/network/interfaces.d file after establishing
# SSID and wi-fi password)
#
setup_ubuntu() {

  echo "${yellow}==> (${host}) Enter SSID:"
  read ssid
  echo "${yellow}==> (${host}) Enter passphrase:"
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
  echo "${white}==> (${host}) Updated /etc/network/interfaces.d/wlp9s0...."

}

# Setup colours
#
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
yellow=$(tput setaf 11)
white=$(tput setaf 15)
reset=$(tput sgr0)# Reset

# Establish distro and call appropriate function
#
host=$(hostname)
echo "${green}==> (${host}) Establishing distro....${reset}"
ubuntu=$(grep -rich ubuntu /etc/os-release /etc/lsb-release 2>/dev/null \
          | awk '{i=i+$1} END {print i}')
if [[ ${ubuntu} -gt 0 ]] ; then
  echo "${white}==> (${host}) Distrubution is Ubuntu....${reset}"
  setup_ubuntu
else
  echo "${red}==> (${host}) Distrubution not supported....${reset}"
  exit 1
fi

# Finished
#
echo "${green}==> (${host}) Wi-Fi setup complete....${reset}"
exit 0
