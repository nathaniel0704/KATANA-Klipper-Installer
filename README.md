<div align="center">
  <img src="https://github.com/user-attachments/assets/9efad6eb-91cf-4e4d-998e-d2c3e4ff433a" width="100%" alt="KATANA Dashboard" />

  # ⚔️ KATANA - Klipper Installation & Management Utility

  [![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
  [![Klipper](https://img.shields.io/badge/Klipper-Ready-green.svg)](https://www.klipper3d.org/)
  [![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)

  > **High-performance Klipper automation for Debian-based systems.** <br>
  > Streamlined deployment with integrated security hardening and diagnostic tools.
</div>

---

## 🚀 Overview

**KATANA** is a CLI utility designed to automate the deployment and management of the **Klipper 3D Printer** stack. While other tools focus purely on installation, KATANA prioritizes **system stability, security hardening, and a centralized workflow.**

It is built for users who want a secure, reliable Klipper environment on any Debian-based host (Raspberry Pi, Orange Pi, or old x86 hardware).

## 📦 Core Modules

### 1. 🟣 Deployment Matrix
A visual status dashboard that verifies the installation state of your core components. It provides instant feedback on whether **Klipper**, **Moonraker**, or **Nginx** are properly integrated into the system.

### 2. ⚡ Dynamic UI Management
Seamlessly switch between **Mainsail** and **Fluidd**. KATANA automatically reconfigures the Nginx reverse proxy to point to your chosen interface without requiring manual config edits or risk of breaking existing services.

### 3. 🤖 Auto-Pilot Deployment
An automated sequence for rapid stack setup:
* **Services:** Klipper, Moonraker, Nginx.
* **UI Options:** Choice between the leading web interfaces.
* **Environment:** Automated Python virtual environment and dependency management.

### 4. 🛡️ System Hardening (Standardized)
KATANA enforces server-grade security practices by default:
* **UFW Integration:** Automated firewall rules limiting access to SSH, HTTP, and API ports.
* **Log2Ram:** Integrated setup to minimize SD card wear-leveling issues by managing logs in RAM.

### 5. 🧩 Integrated Extensions
* **KAMP:** Automated repository setup for adaptive meshing.
    * *Note: Requires manual include in `printer.cfg`.*
* **ShakeTune:** Direct installation of resonance analysis tools for Input Shaper optimization.

## ⚡ Installation

KATANA is designed to be lightweight and fast.

**Requirements:** Any Debian-based OS (Bookworm/Bullseye recommended).

```bash
cd ~
git clone [https://github.com/Extrutex/KATANA-Klipper-Installer.git](https://github.com/Extrutex/KATANA-Klipper-Installer.git)
cd KATANA-Klipper-Installer
chmod +x katana.sh
./katana.sh