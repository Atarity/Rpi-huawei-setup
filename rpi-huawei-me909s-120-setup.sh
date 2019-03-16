#!/bin/bash
# Setting up a Huawei ME909s-120 WWAN card in Raspbian for Beeline ISP.
# Assuming that the PIN authentication is disabled on the SIM card.

set -e

apt-get install -y ppp speedtest-cli

# Setting udev rules to make configuration USB port agnostic
cat >/etc/udev/rules.d/99-huawei-wwan.rules <<'EOT'
SUBSYSTEM=="tty", ATTRS{idVendor}=="12d1", ATTRS{idProduct}=="15c1", SYMLINK+="ttyWWAN%E{ID_USB_INTERFACE_NUM}"
SUBSYSTEM=="net", ATTRS{idVendor}=="12d1", ATTRS{idProduct}=="15c1", NAME="lte0"
EOT

# Disable usb_modeswitch for a modem
sudo sed -i '/^DisableSwitching/ s/0/1/' /etc/usb_modeswitch.conf

# Create dial sequence config
cat >/etc/chatscripts/sunrise.HUAWEI <<'EOT'
ABORT BUSY
ABORT 'NO CARRIER'
ABORT ERROR
TIMEOUT 10
'' ATZ
OK 'AT+CFUN=1'
OK 'AT+CMEE=1'
OK 'AT\^NDISDUP=1,1,"internet.beeline.ru"'
OK
EOT

# Create finish session sequence config
cat >/etc/chatscripts/gsm_off.HUAWEI <<'EOT'
ABORT ERROR
TIMEOUT 5
'' AT+CFUN=0 OK
EOT

# Create new interface for the modem
cat >/etc/network/interfaces.d/lte0 <<'EOT'
allow-hotplug lte0
iface lte0 inet dhcp
    pre-up /usr/sbin/chat -v -f /etc/chatscripts/sunrise.HUAWEI >/dev/ttyWWAN02 </dev/ttyWWAN02
    post-down /usr/sbin/chat -v -f /etc/chatscripts/gsm_off.HUAWEI >/dev/ttyWWAN02 </dev/ttyWWAN02
EOT

echo ""
echo "   To connect and get IP run: sudo ifup -v lte0 "
echo ""
