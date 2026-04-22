# Keyboard Setup

## Overview

My Anne Pro 2 keyboard requires Obinskit to connect via bluetooth. Settings can be a bit of a pain. Perhaps storing the settings info in this repo will help with keeping the settings synced over time. The application is highly unpredictable on windows; I can't seem to find the configuration file where my preferences are saved.

## Installation

winget install ObinsKit.ObinsKit

## First run

1. In PowerShell: `cd $env:PROGRAMFILES/ObinsKit/ && .\ObinsKit.exe`
1. For USB mode:
    1. Ensure Bluetooth mode switch is in off position
    1. Connect keyboard via USB
    1. Run Firmware Upgrade via ObinsKit UI
    1. Set desired settings
    1. Download the settings to the keyboard
1. For Bluetooth mode:
    1. Disconnect USB
    1. Ensure Bluetooth mode switch is in on position
    1. On keyboard, hold down FN2 + 1 for 5 seconds until it flashes
    1. Begin Windows Bluetooth pairing
    1. Set desired settings
    1. Download the settings to the keyboard

## Desired settings

- General
  - Layout
        - custom: true
    - Tap
      - enabled: true
      - sensitivity: 500ms
      - tap key combinations: true
    - Lighting
      - low-power: true
    - Macro
      - enabled: false
    - Magic FN
      - fn1: true
    - Autosleep
      - enabled: true
      - time: 3 minutes
- Layout
  - Device: Anne Pro 2
    - FN2
      - o: volume up
      - u: volume down
    - Download
- Lighting Profiles
  - Default
  - Download
- Audio Visualization
  - enabled: true

<https://manuals.plus/obins/obins-anne-pro-2-manual>
