#!/bin/bash
#
# Setup wifi interface to get onto a network to allow a bootstrap to be downloaed
# and run to configure everything (currently using Salt or Ansible). Initially
# supporting only Ubuntu but to be extended later to other distros.
#
set -o pipefail
set -e

# Setup wifi on Ubuntu (create /etc/wpa_supplicant.conf and an /etc/network/interfaces.d/
# file after establishing wifi interface, SSID and password). If Ubuntu 14 append to
# /etc/network/interfaces as interfaces.d doesn't seem to work.
#
setup_ubuntu() {

  urel="$(lsb_release -sr | cut -c1-2)"

  echo "${white}==>  (${host}) Running on Ubuntu ${red}${urel}"
  echo "${yellow}==> (${host}) Enter wifi device:"
  read devid
  echo "${yellow}==> (${host}) Enter SSID:"
  read ssid
  echo "${yellow}==> (${host}) Enter passphrase:"
  read passphrase
  key=$(/usr/bin/wpa_passphrase "${ssid}" "${passphrase}" \
          | /usr/bin/tr -d ' \t' \
          | /usr/bin/awk -F'=' '$1 == "psk" {print $2}')

  cat > "/etc/wpa_supplicant.conf" <<EOF
network={
  ssid="${ssid}"
  scan_ssid=1
  proto=WPA
  key_mgmt=WPA-PSK
  psk=${key}
}
EOF

  /bin/chmod 600 /etc/wpa_supplicant.conf
  echo "${white}==> (${host}) Updated /etc/wpa_supplicant.conf...."

  if [[ "${urel}" == "14" ]] ; then
    ifile="/etc/network/interfaces"
  else
    ifile="/etc/network/interfaces.d/${devid}"
  fi

  cat >> "${ifile}" <<EOF
# Wireless interface
auto ${devid}
iface ${devid} inet dhcp
    wpa-conf /etc/wpa_supplicant.conf
EOF

  echo "${white}==> (${host}) Updated ${ifile}...."

  echo "${white}==> (${host}) Starting wpa_supplicant on ${devid}...."
  /sbin/wpa_supplicant -i "${devid}" -c /etc/wpa_supplicant.conf -B

  echo "${white}==> (${host}) Starting dhclient on ${devid}...."
  /sbin/dhclient -nw "${devid}"

}

# Setup colours
#
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
yellow=$(tput setaf 11)
white=$(tput setaf 15)
reset=$(tput sgr0)

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
