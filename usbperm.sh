#!/bin/bash
#
dev=`gphoto2 --auto-detect | grep usb | cut -b 36-42 | sed 's/,/\//'`
echo "/dev/bus/usb/${dev}"
sudo chmod 777 /dev/bus/usb/${dev}
exit 0
