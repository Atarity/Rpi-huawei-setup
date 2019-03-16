# Rpi-huawei-setup
Setup script to install Huawei ME909s-120 mPCIe modem on Raspberry Pi. I've connected modem thru cheap mpcie-to-USB adapter with SIM slot and stuck with usb_modeswitch *auto* mode (which should be disabled). Also script add up udev rules, so you can plug modem to any USB port each time.

Script assumes PIN is disabled for the SIM-card auth.

## Installation
```
$ curl -sSOOJ https://raw.githubusercontent.com/Atarity/Rpi-huawei-setup/master/{rpi-huawei-me909s-120-setup.sh,rpi-huawei-me909s-120-remove.sh}

$ chmod +x rpi-huawei-me909s-120-setup.sh rpi-huawei-me909s-120-remove.sh

$ sudo ./rpi-huawei-me909s-120-setup.sh
```
- ***Disconnect modem** from USB port and plug it back.
- You can find new **lte0** interface now: ```ifconfig```
- Connect to cellular network and obtain IP by ```sudo ifup -v lte0```
- Run ```speedtest-cli --source xx.xx.xx.xx``` to test the speed. Replace *xx* with IP modem got.

## Removing
To remove all created configs and bring **usb_modeswitch** to its AUTO switch state simply run:
```
$ sudo ./rpi-huawei-me909s-120-remove.sh
```

This script dependencies *sed* and *yn* is already in default Raspbian package.