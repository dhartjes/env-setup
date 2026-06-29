# Trackpad Setup

<-- [Back to README](../../README.md)

## Overview

It is always such a pain getting the Magic Trackpad 2 USB-C edition working with Windows. This is what I always have do to get it right.

## Prereqs
- 7zip. `winget install 7zip.7zip

## Steps
1. Download https://swcdn.apple.com/content/downloads/03/60/041-96205/61hhcnj7q5dxosc171ytixty20vuqg0r0n/AppleBcUpdate.exe by copy pasting the url into a new tab.
1. Use 7zip to extract the executable file to an uncompressed folder.
1. Turn on the trackpad and attack VIA BLUETOOTH, never USB.
1. Navigate to /ApplePrecisionTrackpadUSB and install the ApplePrecisionTrackpadUSB.inf file with right-click, Install.
1. Navigate to /ApplePrecisionTrackpadBluetooth and install the ApplePrecisionTrackpadBluetooth.inf file with right-click, Install.
1. There is a .inf file there, “ApplePrecisionTrackpadBluetooth.inf”. Right click this and open it in notepad. When doing so confirm that it shows DriverVer = 04/07/2022,6.1.8000.6
1. Open Device manager. A device should show up under “Human Interface Devices” with the name “Bluetooth HID-Device”. 
    1. If you can’t find it: If you have many “Bluetooth HID-Device” and cannot figure out which is the MT2 by disconnecting and reconnecting it
    1. You can check by going to Device manager → Bluetooth → Magic Trackapad → Double  click → Events and note the ID. It should look something like BTHENUM\Dev_346691EF1C10\7&3962ad65&0&BluetoothDevice_346691EF1C10
    1. Right click on the item in the device manager, click on the Details tab and scroll through the various Property values until you see Magic Trackpad in the description.
1. Also in the device manager properties, choose update driver.
    1. Browse my computer for drivers
    1. Let me pick from a list of available Drivers on my Computer
    1. Untick Show Compatible Hardware
    1. Scroll to Apple
    1. Select Apple Bluetooth, Next, Ok
    1. Restart The computer, wait a few minutes and the Trackpad should work as Expected 😊

## Reinstallation steps
1. Run cmd.exe with Administrator
1. Run: Dism /online /Get-Drivers /Format:Table
1. In the list find both of your drivers .inf file. You need to get Published Name (first table) value, e.g. oem11.inf
1. Run for both drivers: pnputil /delete-driver <Published Name> /uninstall /force
1. Reboot and go through Installation Steps one more time.

## Source
https://www.reddit.com/r/bootcamp/comments/ygv1mh/comment/kr8mwze/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

<-- [Back to README](../../README.md)
