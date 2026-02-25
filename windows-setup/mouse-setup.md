# Mouse Setup

## Overview
It is always such a pain getting the Magic Trackpad 2 USB-C edition working with Windows. This is what I always have do to get it right.

## Pre-reqs
Download latest from: https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers/releases


1. Need the ApplePrecisionTrackpadBluetooth/ApplePrecisionTrackpadBluetooth.inf file from the [lc700x/MagicTrackPad2_Windows_Precision_Drivers repo](https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers) which is saved in this repo for convenience.
1. Magic Trackpad 2 USB-C edition device.

## Initial Setup
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
    1. click Next
1. Wait for installation
1. Now your Trackpad should work with Precision menu option in Windows Settings.

## Troubleshooting
If you ever have to disconnect and reconnect, you'll likely encounter an issue. To resolve, see [this issue](https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers/issues/1)


## Links
https://github.com/vitoplantamura/MagicTrackpad2ForWindows/issues/20
https://github.com/vitoplantamura/MagicTrackpad2ForWindows/issues/20#issuecomment-3094498046
https://github.com/lc700x/MagicTrackPad2_Windows_Precision_Drivers
