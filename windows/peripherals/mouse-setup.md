# Trackpad Setup

<-- [Back to README](../../README.md)

## Overview

It is always such a pain getting the Magic Trackpad 2 USB-C edition working with Windows. This is what I always have do to get it right.

## Prereqs

- 7zip. `winget install 7zip.7zip

- Download latest from: https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers/releases
    - Optional other URL: https://swcdn.apple.com/content/downloads/03/60/041-96205/61hhcnj7q5dxosc171ytixty20vuqg0r0n/AppleBcUpdate.exe
- Need the ApplePrecisionTrackpadBluetooth/ApplePrecisionTrackpadBluetooth.inf file from the [lc700x/MagicTrackPad2_Windows_Precision_Drivers repo](https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers) which is saved in this repo for convenience.
- Magic Trackpad 2 USB-C edition device.

## Initial Setup

1. Use 7zip to extract the executable file to an uncompressed folder. (C:\Drivers)
1. Ensure you've never connected via USB.
1. Turn on trackpad via switch.
1. Pair using Windows Bluetooth Pairing.
1. Go to Device Manager
    1. Open the Human Interfaces Devices section
    1. find the listing for Bluetooth HID Device
    1. right click and select Properties
    1. Details tab
    1. select Hardware Ids property
    1. ensure the value starts with BTHENUM\{00001124 as there may be multiple entries with the same name of Bluetooth HID Device
1. Go to Driver tab in the properties window
    1. click Update Driver
    1. Browse my computer for drivers
    1. Let me pick from a list of available drivers on my computer
    1. click Have disk
    1. select the ApplePrecisionTrackpadBluetooth.inf file from ApplePrecisionTrackpadBluetooth folder and click OK
    1. click Next, Yes
1. Wait for installation
1. At this point, the name in the Device Manager will have updated to Apple Bluetooth Precision Trackpad. Right click and choose update driver.
    1. Browse my computer for drivers
    1. Let me pick from a list of available Drivers on my Computer
    1. Untick Show Compatible Hardware
    1. Scroll to Apple in the left window
    1. Double click Apple Bluetooth Precision Trackpad in the right window
    1. Click OK
1. Profit!

## Troubleshooting

If you ever have to disconnect and reconnect, you'll likely encounter an issue. To resolve, see [this issue](https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers/issues/1)

## Reinstallation steps

1. Run cmd.exe with Administrator
1. Run: Dism /online /Get-Drivers /Format:Table
1. In the list find both of your drivers .inf file. You need to get Published Name (first table) value, e.g. oem11.inf
1. Run for both drivers: pnputil /delete-driver <Published Name> /uninstall /force
1. Reboot and go through Installation Steps one more time.

## Source

- https://www.reddit.com/r/bootcamp/comments/ygv1mh/comment/kr8mwze/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

<-- [Back to README](../../README.md)
