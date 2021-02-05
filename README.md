# Hi-Res Audio 24 Bit Enabler Magisk Module

## Descriptions
- Enable hi-res audio format PCM 24 bit for deep buffer, & primary output and primary & fast input through modification of audio policy for supported Android devices. 
- May caused problems in unsupported hardware, unsupported library, and unsupported EQ.

## Screenshots
- https://t.me/audioryukimods/1532

## Requirements
- /system|vendor/etc/audio_policy_configuration.xml
- Magisk installed

## Tested
- Android 10 arm64 CrDroid ROM

## Installation Guide
- Install the module via Magisk Manager only
- Install Audio Modification Library Module if you using other audio mods (If audio mods are not patching audio policy, so it's not required)
- Reboot

## Troubleshootings
- Use Audio Modification Library module if you using other modules which also patching audio_policy_configuration.xml like Audio Compatibilty Patch, Dolby Atmos Oneplus 8 Visible, Audio Wizard Zen 5, and Sound Enhancement.
- If logcat shows still running in PCM 16 bit, mean your audio primary library is not supported for PCM 24 bit.
- Delete /data/adb/modules/HiResAudio folder via recovery if you facing bootloop and send copied and zipped /data/system/dropbox files for fix
- Open issues and send full logcats if this module is not working for your device

## Attention!
- Always make nandroid backup before install or updating version, these are just experiments!
- Don't report anything without logcats!
- Special thanks to all people that helped and tested my modules.

## Telegram
- https://t.me/audioryukimods
- https://t.me/modsandco

## Donate
- https://www.paypal.me/reiryuki

## Download
- Tap "Releases"
