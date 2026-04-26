#!/bin/bash

# --- Banner Section ---
echo -e "\e[1;31m" # Red Color start
echo "#########################################################"
echo "#                                                       #"
echo "#   ██████╗███████╗███████╗      ██████╗███████╗███████╗#"
echo "#  ██╔════╝██╔════╝██╔════╝     ██╔════╝██╔════╝██╔════╝#"
echo "#  ██║     ███████╗█████╗ █████╗██║     ███████╗█████╗  #"
echo "#  ██║     ╚════██║██╔══╝ ╚════╝██║     ╚════██║██╔══╝  #"
echo "#  ╚██████╗███████║██║          ╚██████╗███████║██║     #"
echo "#   ╚═════╝╚══════╝╚═╝           ╚═════╝╚══════╝╚═╝     #"
echo "#                                                       #"
echo "#                CSF-LINUX-CRACKER v1.0                 #"
echo "#          Developed by: Engr. Muzammil Khokhar         #"
echo "#########################################################"
echo -e "\e[0m" # Color reset
# --- Banner End ---

echo "   Linux password reset by WERTH"
echo "-----------------------------------"

# Baki ka script yahan se start hoga...

echo "   Linux password reset by WERTH"
echo "-----------------------------------"

if [[ $EUID -ne 0 ]]; then
   echo "Abba Bhenchod! Script ko root (sudo) se chalayen."
   exit 1
fi

if [[ $1 == "-r" ]]
then
    echo "Scanning available users..."
    # /etc/passwd system ka hi uthaye ga jab tak mount na ho
    awk -F':' '$3 >= 1000 || $3 == 0 {print "\t"$1}' /etc/passwd
    
    read -p "Enter username to reset [root]: " user
    user=${user:-root}

    echo "Available Partitions:"
    lsblk -p | grep "part"
    
    read -p "Enter Linux Partition (e.g., /dev/sda1): " drive
    
    if [ -b "$drive" ]; then
        mount "$drive" /mnt
        echo "Changing Password for User: $user"
        # Seedha chroot ke andar command bhej rahe hain
        chroot /mnt /bin/bash -c "passwd $user"
        
        umount /mnt
        echo "Kaam ho gaya! Partition unmounted. System restart karen."
    else
        echo "Error: Partition valid nahi hai!"
    fi
else
    echo -e "\n\tInstructions"
    echo "\t1. Live Boot Linux from USB"
    echo "\t2. Run: sudo ./linuxPassReset.sh -r\n"
fi
