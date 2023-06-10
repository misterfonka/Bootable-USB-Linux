#!/bin/bash

# Author: misterfonka
# Purpose: Make a bootable drive via the linux terminal.

# List attached USB drives
echo "Attached USB drives:"
lsblk -do NAME,SIZE,MODEL | grep -e '^sd'

# Prompt for drive selection
read -p "Select a USB drive (enter the corresponding drive label, e.g sda): " drive_label

# Ask for the ISO file path
clear
read -p "Enter the path to the ISO file : " iso_file

# Confirm user's choices
clear
echo "Selected USB Drive: $drive_label"
echo "ISO File Path: $iso_file"

echo ""
echo "Are you sure you want to continue?"
echo "This is a dangerous thing to do."
echo "Make sure there is nothing important on this drive."
read -p "Type DoIt to continue. " confirm

if [[ "$confirm" = "DoIt" ]];then
  clear
  echo "Let's do it."
else
  clear
  echo "User didn't want to DoIt... :("
  exit 0
fi

# Unmount the USB drive
clear
echo "Unmounting drive..."
umount "$drive_label"*

# Write the ISO to the USB drive
clear
echo "Writing $iso_file to $drive_label..."
sudo dd bs=4M if=$iso_file of=$drive_label status=progress oflag=sync
clear
echo "Bootable USB created successfully!"
