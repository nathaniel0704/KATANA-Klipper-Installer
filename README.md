<div align="center">
  <img src="https://github.com/user-attachments/assets/9efad6eb-91cf-4e4d-998e-d2c3e4ff433a" width="100%" alt="KATANA Interface" />

  # ⚔️ KATANA - Klipper Deployment Utility

  [![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
  [![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20Raspbian%20%7C%20Armbian-blue.svg)]()
  [![Bash](https://img.shields.io/badge/Language-Bash%20Script-green.svg)]()

  > **Opinionated automation for the modern 3D printing stack.** <br>
  > Deploys a hardened, fully configured Klipper environment in minutes.
</div>

---

## ⚡ Overview

**KATANA** is a CLI utility engineered to streamline the deployment of the Klipper ecosystem. Unlike modular toolboxes that require extensive manual menu navigation, KATANA utilizes an **"Auto-Pilot" workflow** to provision the entire stack (Firmware, API, Reverse Proxy, UI) in a single execution pass.

It is designed for users who treat their 3D printer as a production appliance, prioritizing **security, stability, and reproducible configuration** over manual tinkering.

## 📦 Core Architecture

### 1. 🟣 Deployment Matrix
A real-time dashboard that verifies the installation state of the stack components.
* **Function:** Checks for the presence of Klipper, Moonraker, UI frontends, and system services.
* **Purpose:** Provides immediate visual feedback on which parts of the ecosystem are deployed on the host.

### 2. ⚡ Dynamic Nginx Management
KATANA handles the reverse proxy configuration automatically.
* **Feature:** Switch between **Mainsail** and **Fluidd** instantly via the menu.
* **Mechanism:** The script rewrites the Nginx site configuration (`/etc/nginx/sites-available/klipper`) to point to the selected frontend and restarts the service seamlessly. No manual config editing required.

### 3. 🛡️ System Hardening (Standardized)
Security is not an option; it is a default.
* **UFW Firewall:** Automated rule generation denying all incoming traffic except essential ports (SSH:22, HTTP:80, API:7125).
* **Log2Ram:** Integrates the Log2Ram daemon to redirect system logging to RAM, significantly reducing write cycles on SD cards and preventing corruption during power loss.

### 4. 🧩 Integrated Extension Support
First-class support for modern Klipper extensions.
* **KAMP:** Clones the repo and injects the update manager entry into `moonraker.conf`. (Note: `[include KAMP_Settings.cfg]` must be added to `printer.cfg` manually).
* **ShakeTune:** Automated installation of the Klippain ShakeTune module for advanced input shaper analysis.

### 5. 🤖 Auto-Pilot (God Mode)
The "Auto-Pilot" function executes a linear provisioning script:
1. **System Prep:** Updates `apt`, installs Python3 venv, builds dependencies.
2. **Core Stack:** Clones Klipper/Moonraker, creates systemd services.
3. **Network:** Configures Moonraker auth and CORS for local access.
4. **UI:** Deploys selected frontend and configures Nginx.

## 🛠️ Usage

**Requirements:**
* Hardware: Raspberry Pi (3/4/Zero2), Orange Pi, or generic Linux host.
* OS: Debian Bookworm / Bullseye (Lite recommended).
* User: Standard user with `sudo` privileges.

**Installation:**

```bash
cd ~
git clone https://github.com/Extrutex/KATANA-Klipper-Installer.git
chmod +x katana.sh
./katana.sh
