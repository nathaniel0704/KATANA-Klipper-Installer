#!/bin/bash
################################################################################
#  ⚔️  KATANA - THE KLIPPER BLADE v1.0
# ------------------------------------------------------------------------------
#  THE NEXT-GEN KLIPPER INSTALLATION & UPDATE HELPER
################################################################################

# --- [ 0. CORE ] ---
if [ "$EUID" -eq 0 ]; then echo "STOP. RUN AS USER."; exit 1; fi
USER_NAME=$USER
HOME_DIR=$HOME
PRINTER_DATA="$HOME_DIR/printer_data"
CONFIG_DIR="$PRINTER_DATA/config"
LOG_DIR="$PRINTER_DATA/logs"
WIDTH=70

# --- [ 1. VISUAL ENGINE ] ---
C_PURPLE='\033[38;5;93m'
C_PINK='\033[38;5;201m'
C_CYAN='\033[38;5;51m'
C_NEON='\033[38;5;87m'
C_GREEN='\033[38;5;46m'
C_RED='\033[38;5;196m'
C_GREY='\033[38;5;238m'
C_TXT='\033[38;5;255m'
C_WARN='\033[38;5;226m'
NC='\033[0m'

# Helpers
draw_line() { printf "${C_PURPLE}╠═$(printf '═%.0s' $(seq 1 $WIDTH))═╣${NC}\n"; }
draw_top()  { printf "${C_PURPLE}╔═$(printf '═%.0s' $(seq 1 $WIDTH))═╗${NC}\n"; }
draw_bot()  { printf "${C_PURPLE}╚═$(printf '═%.0s' $(seq 1 $WIDTH))═╝${NC}\n"; }

# Status Row Generator
status_row() {
    name=$1
    check_cmd=$2
    desc=$3
    
    if eval "$check_cmd"; then
        state="${C_GREEN}ONLINE   ${NC}"
        icon="${C_GREEN}●${NC}"
    else
        state="${C_GREY}OFFLINE  ${NC}"
        icon="${C_GREY}○${NC}"
    fi
    
    # Padding magic for perfect alignment
    printf "${C_PURPLE}║${NC}  ${icon} ${C_NEON}%-15s${NC} : %-20s ${C_GREY}▒ %-25s${NC} ${C_PURPLE}║${NC}\n" "$name" "$state" "$desc"
}

# Menu Item Generator
menu_item() {
    id=$1
    title=$2
    desc=$3
    printf "${C_PURPLE}║${NC} ${C_PINK}[$id]${NC} ${C_CYAN}%-25s${NC} ${C_GREY}%-38s${NC} ${C_PURPLE}║${NC}\n" "$title" "$desc"
}

# --- [ 2. HEADER & STATUS GRID ] ---
draw_gui() {
    clear
    # Logo
    echo -e "${C_PURPLE}"
    cat << "EOF"
      /\                                                                     
     /  \      _  __       _______       _   _           ____   _____ 
    |    |    | |/ /      |__   __|     | \ | |   /\    / __ \ / ____|
    |    |    | ' /  __ _    | |  __ _  |  \| |  /  \  | |  | | (___  
    |    |    |  <  / _` |   | | / _` | | . ` | / /\ \ | |  | |\___ \ 
    |    |    | . \| (_| |   | || (_| | | |\  |/ ____ \| |__| |____) |
     \  /     |_|\_\\__,_|   |_| \__,_| |_| \_/_/    \_\\____/|_____/ 
      \/                                                 v1.1 NEON
EOF
    echo -e "${C_NEON}   >> SYSTEM OVERLORD // COMMAND INTERFACE${NC}"
    
    draw_top
    printf "${C_PURPLE}║${NC} ${C_TXT}%-68s${NC} ${C_PURPLE}║${NC}\n" " SYSTEM STATUS MATRIX"
    draw_line
    
    # --- LIVE STATUS CHECKS ---
    status_row "Klipper" "[ -d ~/klipper ]" "3D Printer Firmware"
    status_row "Moonraker" "[ -d ~/moonraker ]" "API Server"
    status_row "Mainsail/Fluidd" "[ -d ~/mainsail ] || [ -d ~/fluidd ]" "Web Interface"
    status_row "Crowsnest" "[ -d ~/crowsnest ]" "Webcam Daemon"
    status_row "KlipperScreen" "[ -d ~/KlipperScreen ]" "Touch Interface"
    draw_line
    status_row "KAMP" "[ -d ~/Klipper-Adaptive-Meshing-Purging ]" "Adaptive Meshing"
    status_row "ShakeTune" "[ -d ~/klippain_shaketune ]" "Input Shaper Tools"
    status_row "System Sec" "command -v ufw >/dev/null" "Firewall & Log2Ram"
    draw_bot
    
    echo ""
    draw_top
    printf "${C_PURPLE}║${NC} ${C_TXT}%-68s${NC} ${C_PURPLE}║${NC}\n" " COMMAND DECK"
    draw_line
    
    # --- MENU ITEMS ---
    printf "${C_PURPLE}║${NC} ${C_TXT} [ INSTALLATION ]                                                   ${C_PURPLE}║${NC}\n"
    menu_item "1" "AUTO-PILOT" "Full Stack Install (God Mode)"
    menu_item "2" "CORE ENGINE" "Klipper, Moonraker & Nginx"
    menu_item "3" "WEB INTERFACE" "Mainsail / Fluidd"
    menu_item "4" "MEDIA CENTER" "Crowsnest & KlipperScreen"
    draw_line
    printf "${C_PURPLE}║${NC} ${C_TXT} [ CONFIGURATION ]                                                  ${C_PURPLE}║${NC}\n"
    menu_item "5" "THE FORGE" "Firmware Flashing"
    menu_item "6" "EXTENSIONS" "KAMP & ShakeTune"
    menu_item "7" "GET CONFIG" "Copy Example Printer Config"
    draw_line
    printf "${C_PURPLE}║${NC} ${C_TXT} [ MAINTENANCE ]                                                    ${C_PURPLE}║${NC}\n"
    menu_item "8" "SYSTEM PREP" "Updates & Dependencies"
    menu_item "9" "SEC & BACKUP" "Firewall, Log2Ram & Zip Backup"
    draw_line
    menu_item "X" "EXIT" "Close Katana"
    draw_bot
    
    echo ""
    echo -e "${C_GREY}  USER: $USER_NAME  |  IP: $(hostname -I | cut -d' ' -f1)  |  SYSTEM: READY${NC}"
    echo ""
}

# --- [ 3. LOGIC (THE WORKERS) ] ---
# (Keeping the logic robust, but hidden behind the UI)

exec_silent() {
    echo -e "\n${C_CYAN}  [..] EXECUTING: $1...${NC}"
    echo -e "${C_GREY}  >> ------------------------------------------${NC}"
    eval "$2"
    local status=$?
    echo -e "${C_GREY}  << ------------------------------------------${NC}"
    if [ $status -eq 0 ]; then 
        echo -e "${C_GREEN}  [OK] $1 COMPLETE${NC}"
    else 
        echo -e "${C_RED}  [!!] $1 FAILED${NC}"
    fi
}

do_prep() {
    exec_silent "Update Apt" "sudo apt update"
    exec_silent "Install Tools" "sudo apt install -y git zip unzip silversearcher-ag wavemon hexedit tcpdump iptraf mc htop dcfldd nano usbutils ranger tldr ncdu can-utils multitail fd-find build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi python3-pip python3-venv dfu-util nginx libsodium-dev libffi-dev"
    exec_silent "Purge Bloat" "sudo apt autoremove -y modem* cups* pulse* avahi* triggerhappy*"
    read -p "  Press Enter..."
}

do_core() {
    mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$PRINTER_DATA/comms"
    exec_silent "Clone Klipper" "[ -d ~/klipper ] || git clone https://github.com/Klipper3d/klipper.git ~/klipper"
    exec_silent "Build Env" "rm -rf ~/klipper-env && python3 -m venv ~/klipper-env && ~/klipper-env/bin/pip install -U pip && ~/klipper-env/bin/pip install -r ~/klipper/scripts/klippy-requirements.txt"
    # Service
    sudo tee /etc/systemd/system/klipper.service > /dev/null << EOF
[Unit]
Description=Klipper
After=network.target
[Service]
Type=simple
User=$USER_NAME
RemainAfterExit=yes
ExecStart=$HOME_DIR/klipper-env/bin/python $HOME_DIR/klipper/klippy/klippy.py $CONFIG_DIR/printer.cfg -l $LOG_DIR/klippy.log -a $PRINTER_DATA/comms/klippy.sock
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl daemon-reload
    sudo systemctl enable klipper.service >/dev/null 2>&1
    
    exec_silent "Clone Moonraker" "[ -d ~/moonraker ] || git clone https://github.com/Arksine/moonraker.git ~/moonraker"
    # Config
    cat > "$CONFIG_DIR/moonraker.conf" << EOF
[server]
host: 0.0.0.0
port: 7125
klippy_uds_address: $PRINTER_DATA/comms/klippy.sock
[authorization]
force_logins: False
cors_domains:
    *
    *.local
    *.lan
    *://app.fluidd.xyz
    *://my.mainsail.xyz
trusted_clients:
    10.0.0.0/8
    127.0.0.0/8
    169.254.0.0/16
    172.16.0.0/12
    192.168.0.0/16
    FE80::/10
    ::1/128
[file_manager]
enable_object_processing: True
[update_manager]
channel: dev
refresh_interval: 168
[update_manager mainsail]
type: web
channel: stable
repo: mainsail-crew/mainsail
path: ~/mainsail
[update_manager fluidd]
type: web
channel: stable
repo: fluidd-core/fluidd
path: ~/fluidd
EOF
    exec_silent "Install Moonraker" "~/moonraker/scripts/install-moonraker.sh -f -c $CONFIG_DIR/moonraker.conf"
    
    # Config Handling
    if [ ! -f "$CONFIG_DIR/printer.cfg" ]; then
        echo -e "${C_PINK}  >> No printer.cfg found.${NC}"
        echo -e "  1) Create Minimal (Virtual)  2) Copy from Klipper Examples"
        read -p "  >> " cfgo
        if [ "$cfgo" == "2" ]; then
             do_get_config
        else
             echo -e "[include mainsail.cfg]\n[mcu]\nserial: /dev/null\n[printer]\nkinematics: none\nmax_velocity: 100\nmax_accel: 100" > "$CONFIG_DIR/printer.cfg"
        fi
        touch "$CONFIG_DIR/mainsail.cfg"
    fi

    sudo systemctl restart moonraker
    read -p "  Press Enter..."
}

do_ui() {
    echo -e "  1) Mainsail  2) Fluidd"
    read -p "  >> " uich
    UI="mainsail"
    [ "$uich" == "2" ] && UI="fluidd"
    exec_silent "Install $UI" "rm -rf ~/$UI && mkdir -p ~/$UI && cd ~/$UI && wget -q -O ui.zip https://github.com/${UI}-crew/${UI}/releases/latest/download/${UI}.zip || wget -q -O ui.zip https://github.com/${UI}-core/${UI}/releases/latest/download/${UI}.zip && unzip -o ui.zip && rm ui.zip"
    # NGINX
    sudo tee /etc/nginx/sites-available/klipper > /dev/null << EOF
server {
    listen 80;
    server_name _;
    client_max_body_size 500M;
    location / { root $HOME_DIR/$UI; index index.html; try_files \$uri \$uri/ /index.html; }
    location /server { proxy_pass http://127.0.0.1:7125; proxy_set_header Upgrade \$http_upgrade; proxy_set_header Connection "upgrade"; }
    location /websocket { proxy_pass http://127.0.0.1:7125/websocket; proxy_http_version 1.1; proxy_set_header Upgrade \$http_upgrade; proxy_set_header Connection "upgrade"; }
}
EOF
    sudo rm -f /etc/nginx/sites-enabled/default
    sudo ln -sf /etc/nginx/sites-available/klipper /etc/nginx/sites-enabled/
    sudo systemctl restart nginx
    read -p "  Press Enter..."
}

do_extras() {
    # KAMP
    exec_silent "KAMP" "rm -rf ~/Klipper-Adaptive-Meshing-Purging && git clone https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging.git ~/Klipper-Adaptive-Meshing-Purging && cp ~/Klipper-Adaptive-Meshing-Purging/Configuration/KAMP_Settings.cfg $CONFIG_DIR/"
    sed -i '/\[update_manager Klipper-Adaptive-Meshing-Purging\]/,/primary_branch: main/d' "$CONFIG_DIR/moonraker.conf"
    cat >> "$CONFIG_DIR/moonraker.conf" << EOF

[update_manager Klipper-Adaptive-Meshing-Purging]
type: git_repo
channel: dev
path: ~/Klipper-Adaptive-Meshing-Purging
origin: https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging.git
managed_services: klipper
primary_branch: main
EOF
    # ShakeTune
    exec_silent "ShakeTune" "rm -rf ~/klippain_shaketune && git clone https://github.com/Frix-x/klippain-shaketune.git ~/klippain_shaketune && ~/klippain_shaketune/install.sh"
    sed -i '/\[update_manager klippain-shaketune\]/,/managed_services: klipper/d' "$CONFIG_DIR/moonraker.conf"
    cat >> "$CONFIG_DIR/moonraker.conf" << EOF

[update_manager klippain-shaketune]
type: git_repo
origin: https://github.com/Frix-x/klippain-shaketune.git
path: ~/klippain_shaketune
virtualenv: ~/klippain_shaketune-env
requirements: requirements.txt
system_dependencies: system-dependencies.json
primary_branch: main
managed_services: klipper
EOF
    sudo systemctl restart moonraker
    read -p "  Press Enter..."
}

do_media() {
    echo -e "  1) Crowsnest (Webcam)  2) KlipperScreen (Touch)"
    read -p "  >> " mch
    if [ "$mch" == "1" ]; then
        exec_silent "Install Crowsnest" "git clone https://github.com/mainsail-crew/crowsnest.git ~/crowsnest && cd ~/crowsnest && sudo make install"
    fi
    if [ "$mch" == "2" ]; then
        exec_silent "Install KlipperScreen" "git clone https://github.com/KlipperScreen/KlipperScreen.git ~/KlipperScreen && ~/KlipperScreen/scripts/KlipperScreen-install.sh"
    fi
    read -p "  Press Enter..."
}

do_get_config() {
    if [ ! -d ~/klipper/config ]; then echo -e "${C_RED}  Klipper not found. Install Core first.${NC}"; return; fi
    echo -e "${C_CYAN}  >> Select a config template to copy to printer.cfg:${NC}"
    
    # Use select for a simple menu of generic configs
    PS3="  Enter number (q to quit): "
    select filename in $(ls ~/klipper/config/generic-*.cfg | xargs -n 1 basename); do
        if [ -n "$filename" ]; then
            cp ~/klipper/config/$filename "$CONFIG_DIR/printer.cfg"
            echo -e "${C_GREEN}  [OK] Copied $filename to $CONFIG_DIR/printer.cfg${NC}"
            break
        elif [ "$REPLY" == "q" ]; then
            break
        else
            echo "Invalid selection."
        fi
    done
}

do_forge() {
    echo "  1) STM32 2) RP2040 3) Host 4) Scan"
    read -p "  >> " f
    cd ~/klipper
    if [ "$f" == "1" ]; then exec_silent "Build" "make menuconfig && make clean && make -j4"; sudo dfu-util -a 0 -d 0483:df11 -s 0x08000000:leave -D out/klipper.bin; fi
    if [ "$f" == "2" ]; then exec_silent "Build" "make menuconfig && make clean && make -j4"; make flash FLASH_DEVICE=2e8a:0003; fi
    if [ "$f" == "3" ]; then exec_silent "Build" "make clean && make menuconfig && make flash"; sudo cp ./scripts/klipper-mcu.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl enable klipper-mcu.service; fi
    if [ "$f" == "4" ]; then ls -l /dev/serial/by-id/*; read; fi
}

do_maint() {
    echo -e "  1) Security (Firewall/Log2Ram)  2) Backup Config"
    read -p "  >> " mch
    if [ "$mch" == "1" ]; then
    exec_silent "Log2Ram" "echo 'deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ bookworm main' | sudo tee /etc/apt/sources.list.d/azlux.list && sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg https://azlux.fr/repo.gpg && sudo apt update && sudo apt install -y log2ram"
    exec_silent "UFW Firewall" "sudo apt install -y ufw && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw allow 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 7125/tcp && sudo ufw --force enable"
    sudo usermod -a -G tty,dialout,gpio,i2c $USER_NAME
    sudo chown -R $USER_NAME:$USER_NAME "$PRINTER_DATA"
    chmod 755 $HOME_DIR
    sudo systemctl restart klipper moonraker nginx
    fi
    if [ "$mch" == "2" ]; then
    TS=$(date +%Y%m%d_%H%M%S)
    BACKUP_FILE="$HOME_DIR/klipper_backup_$TS.zip"
    exec_silent "Backup Config" "zip -r $BACKUP_FILE $PRINTER_DATA/config"
    echo -e "${C_GREEN}  >> Backup created: $BACKUP_FILE${NC}"
    fi
    read -p "  Press Enter..."
}

# --- [ 4. MAIN LOOP ] ---
while true; do
    draw_gui
    echo -ne "${C_PINK}  >> COMMAND:${NC} "
    read choice
    case $choice in
        1) do_prep; do_core; do_ui; do_media; do_extras; do_maint ;;
        2) do_core ;;
        3) do_ui ;;
        4) do_media ;;
        5) do_forge ;;
        6) do_extras ;;
        7) do_get_config ;;
        8) do_prep ;;
        9) do_maint ;;
        [Xx]) clear; exit 0 ;;
    esac
done