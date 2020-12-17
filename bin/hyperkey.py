#!/usr/bin/env python3

import subprocess

import pyudev

KENISIS = "Device('/sys/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.2/1-5.2:1.0')"


def main():
    context = pyudev.Context()
    monitor = pyudev.Monitor.from_netlink(context)
    monitor.filter_by(subsystem="usb")
    monitor.start()

    for device in iter(monitor.poll, None):
        # I can add more logic here, to run different scripts for different devices.
        if str(device) == KENISIS:
            try:
                print(device)
                subprocess.call(["/home/ahonnecke/bin/hyperkey.sh"])
            except Exception:
                pass
        else:
            print(f"NOT {device}")


if __name__ == "__main__":
    main()
