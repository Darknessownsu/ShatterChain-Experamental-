# SHATTERCHAIN.sh — macOS Trust Chain Crippler

**Version:** 0.9 (Experimental)  
**Author:** Darknessownsu

---

## WARNING

SHATTERCHAIN is not a standard macOS utility.  
It is a **system-level corruption tool** designed to:
- Cripple macOS trust mechanisms
- Block Apple activation and MDM verification
- Simulate a post-activation state
- Mutate a locked system into a bootable, disconnected environment

**This is NOT a true iCloud bypass.**  
It does NOT remove iCloud Activation Lock.  
It **disrupts the activation flow** and masks device state for *research and testing purposes only*.

---

## Features

- Blocks Apple DEP and iCloud endpoints via `/etc/hosts`
- Removes Setup Assistant and creates `/var/db/.AppleSetupDone`
- Spoofs activation state flags
- Kills activation daemons (`mobileactivationd`, `findmymac`)
- Forges lockdown activation record
- Logs execution into `/var/log/mirrorbl00m.log`
- Cripples software update framework
- Leaves system "unblessed" and off-grid

---

## Installation & Usage

### 1. **Transfer to Target Mac**

Place `SHATTERCHAIN.sh` on your target Mac. Example:
```bash
scp SHATTERCHAIN.sh user@target-mac.local:~/Desktop/
```

### 2. **Boot into Recovery Mode**

Hold **Command + R** (Intel) or **Power + Options** (Apple Silicon) to enter Recovery Mode.  
Open **Terminal** from the Utilities menu.

### 3. **Mount Root Volume**

```bash
mount -uw /
```

### 4. **Run SHATTERCHAIN**

```bash
chmod +x SHATTERCHAIN.sh
sudo ./SHATTERCHAIN.sh
```

---

## Output & Trace

A log entry will be created at:

```
/var/log/mirrorbl00m.log
```

You may inspect it to verify successful mutation.  
Permissions will be restricted (`chmod 400`) to simulate ghost logging.

---

## Known Side Effects

- FaceTime / iMessage will **not work**
- macOS software updates may fail
- Apple Support Diagnostics will not function
- Activation Lock screen may **still show**, but activation will be stalled
- System is no longer compliant with T2/M1 secure boot expectations

---

## Legal Note

Use only on devices you own or have administrative rights to.  
This script is provided **as-is for educational or research use only**.

---

> _“This doesn’t unlock the Mac. It unchains the ghost that used to obey.”_  
> — Darknessownsu
