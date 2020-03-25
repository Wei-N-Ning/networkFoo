# Install BrosTrend AC1200 driver on Ubuntu 18 - Dell Precision 5540

## install driver

source: <https://ubuntuforums.org/showthread.php?t=2394372>

steps:

**NOTE** copy and execute each line one-by-one!!!

I made a clone of the original git repo

<https://github.com/powergun/rtl88x2BU_WiFi_linux_v5.2.4.4_25643.20171212_COEX20171012-5044>

```shell
sudo apt-get update
sudo apt-get install build-essential git
git clone https://github.com/cilynx/rtl88x2BU_WiFi_linux_v5.2.4.4_25643.20171212_COEX20171012-5044.git
cd rtl88x2BU_WiFi_linux_v5.2.4.4_25643.20171212_COEX20171012-5044
export VER=$(cat ./version)
sudo rsync -rvhP ./ /usr/src/rtl88x2bu-${VER}
sudo dkms add -m rtl88x2bu -v ${VER}
sudo dkms build -m rtl88x2bu -v ${VER}
sudo dkms install -m rtl88x2bu -v ${VER}
sudo modprobe 88x2bu
```

## restart and disable built-in wifi card

F12 -> one time boot menu -> bios settings -> wifi

turn off wifi switch and wifi device enabled; leave the bluetooth checkboxes alone;

restart

## verify the wifi connection

on ubuntu system tray, the wifi connection should show up as turned off, reconnect it

## verify the installation

`sudo lshw -C network`

should show up something like

```text
weining@weining-ubuntu:~$ sudo lshw -C network
  *-network
       description: Wireless interface
       physical id: 2
       bus info: usb@1:1
       logical name: wlx74ee2afde833
       serial: 74:ee:2a:fd:e8:33
       capabilities: ethernet physical wireless
       configuration: broadcast=yes driver=rtl88x2bu ip=192.168.0.12 multicast=yes wireless=IEEE 802.11an
```
