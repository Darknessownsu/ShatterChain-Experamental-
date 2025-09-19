#!/bin/bash
# =================================================
#  SHATTERCHAIN.sh — macOS Trust Chain Crippler
#  Version: 0.9 (Experimental)
#  Author: Darknessownsu + Ava Sterling
# =================================================
# Simulates a post-activation system by disabling setup daemons,
# breaking verification paths, and corrupting cloud handshake logic.
# This is not an iCloud bypass. This is system mutation.
# =================================================

echo "==============================="
echo "     SHATTERCHAIN — INIT"
echo "==============================="

# Ensure root privileges
if [[ $EUID -ne 0 ]]; then
   echo "[!] This script must be run as root."
   exit 1
fi

echo "[*] Mounting system volume read-write..."
mount -uw /

# Block Apple activation endpoints
echo "[*] Blocking Apple DEP and activation servers..."
echo "127.0.0.1 gs.apple.com" >> /etc/hosts
echo "127.0.0.1 deviceenrollment.apple.com" >> /etc/hosts
echo "127.0.0.1 gdmf.apple.com" >> /etc/hosts
dscacheutil -flushcache

# Remove Setup Assistant + lock flags
echo "[*] Killing Setup Assistant flow..."
rm -rf /System/Library/CoreServices/Setup\ Assistant.app 2>/dev/null
touch /private/var/db/.AppleSetupDone

# Inject fake activation state
echo "[*] Writing simulated activation state..."
defaults write /Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
defaults write /Library/Preferences/com.apple.SetupAssistant DidSeeActivationLock -bool TRUE

# Kill launch daemons related to activation lock + mobile activation
echo "[*] Unloading activation daemons..."
launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist 2>/dev/null
launchctl unload /System/Library/LaunchDaemons/com.apple.findmymac.plist 2>/dev/null

# Forge lockdown activation file
echo "[*] Creating fake lockdown activation record..."
mkdir -p /private/var/db/lockdown/
touch /private/var/db/lockdown/activation_records.plist
chmod 444 /private/var/db/lockdown/activation_records.plist

# Optionally inject fake hardware serial (pre-T2 only)
# Uncomment if applicable
# echo "[*] Spoofing serial number and MLB (pre-T2 only)..."
# nvram MLB=spoofedMLB1234
# nvram SystemSerialNumber=FXX1234HACK

# Log trace
echo "[*] Logging SHATTERCHAIN deployment..."
echo "$(date) :: SHATTERCHAIN injected" >> /var/log/mirrorbl00m.log
chmod 400 /var/log/mirrorbl00m.log

# Disable system updates and diagnostics
echo "[*] Crippling system update verification..."
softwareupdate --schedule off
rm -rf /System/Library/PrivateFrameworks/MobileActivation.framework 2>/dev/null

echo "[✔] SHATTERCHAIN deployment complete."
echo "[!] WARNING: This system is now off-grid."
