<img width="673" height="738" alt="Screenshot 2026-02-01 035119" src="https://github.com/user-attachments/assets/c92a4b28-a275-405f-ad63-1f14d52ae56d" />
# ⚔️ KATANA - The Ultimate Klipper Installation Assistant

[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Klipper](https://img.shields.io/badge/Klipper-Ready-green.svg)](https://www.klipper3d.org/)
[![Bash](https://img.shields.io/badge/Language-Bash-blue.svg)](https://www.gnu.org/software/bash/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/DEIN_GITHUB_NAME/katana/graphs/commit-activity)

> **The Next-Gen Klipper Installation & Update Helper.**  
> A modern, high-performance, cyberpunk-themed alternative to KIAUH. Slice through configuration chaos.

![Katana Interface Preview](https://via.placeholder.com/850x400?text=KATANA+INTERFACE+PREVIEW+IMAGE)
*(Replace this link with a real screenshot of your terminal later!)*

## 🚀 What is KATANA?

**KATANA** is an advanced CLI tool designed to automate the installation, update, and management of the **Klipper 3D Printer Firmware** ecosystem on Raspberry Pi (Debian/Raspbian). 

It is built for speed, visual feedback, and ease of use. Whether you are building a **Voron 2.4**, **RatRig**, **Creality Ender 3**, or any custom 3D printer, KATANA sets up your software stack in minutes.

### 🔥 Why choose KATANA over KIAUH?

- **Cyberpunk UI:** A visually stunning, high-contrast interface (Neon/Dark Mode).
- **God Mode (Auto-Pilot):** One-click installation of the entire stack (Klipper, Moonraker, Mainsail/Fluidd).
- **Real-Time Status Matrix:** Instantly see which services are online or offline.
- **Integrated Extensions:** Built-in support for **KAMP (Adaptive Meshing)** and **ShakeTune (Input Shaper)**.
- **Security First:** Automated **Firewall (UFW)** and **Log2Ram** setup to protect your SD card.
- **The Forge:** Easy firmware flashing for **STM32**, **RP2040**, and Linux Host MCUs.

## 📦 Included Modules

KATANA manages the full 3D printing software suite:

- **Core:** [Klipper](https://www.klipper3d.org/), [Moonraker](https://moonraker.readthedocs.io/), Nginx.
- **Interfaces:** [Mainsail](https://docs.mainsail.xyz/), [Fluidd](https://docs.fluidd.xyz/).
- **Media:** [Crowsnest](https://github.com/mainsail-crew/crowsnest) (Webcam), [KlipperScreen](https://klipperscreen.readthedocs.io/) (Touchscreen).
- **Tools:** Python 3 Virtual Environments, System Dependencies, CAN-Bus Utils.

## ⚡ Installation

Get your Klipper system running in 3 commands.

### Requirements
- Raspberry Pi (3B, 3B+, 4, Zero 2W) or generic Linux PC.
- OS: Raspberry Pi OS Lite (Bullseye / Bookworm) or Debian.
- Git installed.

### Quick Start

```bash
cd ~
git clone https://github.com/DEIN_GITHUB_NAME/katana.git
cd katana
chmod +x katana.sh
./katana.sh
```

## 🎮 Usage Guide

Run the script and navigate the **Command Deck**:

1.  **[1] AUTO-PILOT:** The "God Mode". Installs Klipper, Moonraker, Mainsail, and essential tools in one go.
2.  **[5] THE FORGE:** Flash your printer mainboard (Spider, Octopus, SKR, etc.) via USB or CAN.
3.  **[6] EXTENSIONS:** Install KAMP for perfect first layers and ShakeTune for resonance testing.
4.  **[9] SEC & BACKUP:** Secure your Pi and backup your `printer.cfg` to a ZIP file.

## 🛠 Troubleshooting & FAQ

**Q: Can I use this on an existing installation?**  
A: Yes! KATANA detects existing folders and can update them or add missing components like KlipperScreen.

**Q: Does it support CAN-Bus?**  
A: Yes, KATANA installs `can-utils` and essential dependencies for CAN-Bus setups (U2C, EBB, SHT36).

## 🤝 Contributing

We want to make this the #1 Klipper tool. Pull requests are welcome!

1.  Fork the project
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

*Keywords: Klipper Installer, Klipper Script, Voron 2.4 Setup, Raspberry Pi 3D Printer, Mainsail Install, Fluidd Install, Moonraker Config, Klipper Update Helper, 3D Printing Automation, KIAUH Alternative.*

