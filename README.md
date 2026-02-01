<img width="605" height="668" alt="Screenshot 2026-02-01 133317" src="https://github.com/user-attachments/assets/9efad6eb-91cf-4e4d-998e-d2c3e4ff433a" />

  # ⚔️ KATANA - The Ultimate Klipper Installation Architect

  [![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
  [![Klipper](https://img.shields.io/badge/Klipper-Ready-green.svg)](https://www.klipper3d.org/)
  [![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)
  [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()

  > **The Next-Gen Klipper Automation System.** <br>
  > A modern, high-performance, cyberpunk-themed installer. Slice through configuration chaos.
</div>

---

## 🚀 What is KATANA?

**KATANA** is an advanced system architect designed to automate the installation, hardening, and management of the **Klipper 3D Printer Firmware** ecosystem on Raspberry Pi (Debian/Raspbian). 

Unlike other installers that just fetch files, **KATANA** focuses on **system security, workflow automation, and "God Mode" efficiency**. It sets up a fully hardened print server in minutes.

### 🔥 Why choose KATANA?

| Feature | KATANA OS ⚔️ | Standard Installers |
| :--- | :--- | :--- |
| **Interface** | Cyberpunk Visual Status Matrix | Text Lists |
| **Workflow** | **Auto-Pilot** (Install Stack + Configs in 1 Click) | Manual Step-by-Step |
| **Smart Extras** | **KAMP (Purging)** & **ShakeTune** Auto-Injected | Manual setup required |
| **Security** | **UFW Firewall** & **Log2Ram** Auto-Setup | Usually ignored |
| **Firmware** | **The Forge** (Integrated Flashing Menu) | Manual `make menuconfig` |

## 📦 Key Features

### 1. 🟣 The Status Matrix
A real-time dashboard that checks your installation live. See instantly if **Klipper**, **Moonraker**, or **Nginx** are running, missing, or require updates.

### 2. 🤖 Auto-Pilot (God Mode)
One-click installation of the complete stack:
* **Core:** Klipper, Moonraker, Nginx (Auto-configured).
* **UI:** Mainsail or Fluidd.
* **System:** Dependencies, Python Env, Crowsnest.

### 3. 🛡️ Fortress Security (Hardening)
KATANA treats your 3D printer like a server:
* **UFW Firewall:** Automatically configured to block unauthorized ports, allowing only SSH, HTTP, and API access.
* **Log2Ram:** Pre-configured to extend your SD card's lifespan by writing logs to RAM instead of disk (prevents corruption on power loss).

### 4. 🧩 Extensions: KAMP & ShakeTune
* **KAMP (Smart Purging):** KATANA installs the repository and generates the necessary configuration files.
    * *⚠️ **Manual Action Required:** KATANA does not modify your `printer.cfg` automatically. You must manually add `[include KAMP_Settings.cfg]` and update your `PRINT_START` macro to use `LINE_PURGE` or `VORON_PURGE`.*
* **ShakeTune:** Fully automated installation for Input Shaper resonance testing and graph generation.

## ⚡ Installation

Get your Klipper system running in 3 commands.

**Requirements:** Raspberry Pi (3B, 4, Zero 2W) running Raspberry Pi OS Lite (Bookworm/Bullseye).

```bash
cd ~
git clone [https://github.com/DEIN_GITHUB_NAME/KATANA-Klipper-Installer.git](https://github.com/DEIN_GITHUB_NAME/KATANA-Klipper-Installer.git)
cd KATANA-Klipper-Installer
chmod +x katana.sh
./katana.sh


