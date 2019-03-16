# Rpi-huawei-setup
Setup script to install Huawei ME909s-120 mPCIe modem on Raspberry Pi. I've connected modem thru cheap mpcie-to-USB adapter with SIM slot and stuck with usb_modeswitch *auto* mode (which should be disabled). 

## Installation
```
$ curl -sSOOJ https://raw.githubusercontent.com/Atarity/Rpi-huawei-setup/master/{rpi-huawei-me909s-120-setup.sh, rpi-huawei-me909s-120-remove.sh}

$ chmod +x rpi-huawei-me909s-120-setup.sh rpi-huawei-me909s-120-remove.sh

$ sudo ./rpi-huawei-me909s-120-setup.sh
```
- After that you can find new **lte0** interface: ```ifconfig```
- Connect to cellular network and obtain IP by ```sudo ifup -v lte0```
- Run ```speedtest-cli --source xx.xx.xx.xx``` to test the speed. Replace *xx* with IP modem got.

## Removing
To remove all created configs and bring **usb_modeswitch** to its AUTO switch state simply run:
```
$ sudo ./rpi-huawei-me909s-120-remove.sh
```

This script dependencies *sed* and *yn* is already in default Raspbian package.