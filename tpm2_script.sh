#!/usr/bin/bash

# Set encrypted disk UUID
export UUID=8c8e8d9e-a589-4c06-8dd1-56770b089513

# Add decryption key to tpm. 
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+4+7 /dev/nvme0n1p3

# Wipe old keys and enroll new key. You have to execute this command again after a kernel upgrade.
# systemd-cryptenroll /dev/nvme0n1p3 --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0,2,4,7

# Add tpm2 configuration option to /etc/crypttab
# luks-$UUID UUID=disk-$UUID none tpm2-device=auto,discard

# Update initramfs (to get necessary tpm2 libraries and parameters for decryption into initramfs)
dracut -f
