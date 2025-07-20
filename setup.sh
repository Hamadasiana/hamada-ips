#!/bin/bash

# --- حماية مزدوجة (IP + مفتاح يدوي) ---

# التحقق من IP من GitHub
MYIP=$(curl -s ipv4.icanhazip.com)
ALLOWED_IPS_URL="https://raw.githubusercontent.com/Hamadasiana/hamada-ips/main/ipvps"
AUTHORIZED=$(curl -s "$ALLOWED_IPS_URL" | grep "$MYIP")

if [[ -z "$AUTHORIZED" ]]; then
    echo -e "\e[1;31m⛔ هذا السيرفر غير مصرح له باستخدام السكربت.\e[0m"
    exit 1
fi

# التحقق من المفتاح السري من المستخدم
read -p "🔑 أدخل مفتاح التفعيل الخاص بك: " ENTERED_KEY
REAL_KEY="hamada2025"

if [[ "$ENTERED_KEY" != "$REAL_KEY" ]]; then
    echo -e "\e[1;31m⛔ مفتاح التفعيل غير صحيح.\e[0m"
    exit 1
fi

echo -e "\e[1;32m✅ تم التحقق من IP والمفتاح بنجاح.\e[0m"


#!/bin/bash

# VIP-Autoscript Universal Installer
# Author: Active media (2025)
# Purpose: Automatic deployment for all VPN services/scripts included in this package.

clear
echo "========================================"
echo "    VIP-Autoscript Universal Installer  "
echo "========================================"
echo
echo "Starting automated setup for all included VPN services..."
sleep 2

# Detect OS (Ubuntu/Debian recommended)
if [ -f /etc/debian_version ]; then
    OS="debian"
elif [ -f /etc/centos-release ]; then
    OS="centos"
else
    echo "Unsupported OS. Please use Debian/Ubuntu/CentOS."
    exit 1
fi

# Update & Upgrade
echo "[*] Updating system packages..."
if [ "$OS" = "debian" ]; then
    apt-get update -y && apt-get upgrade -y
elif [ "$OS" = "centos" ]; then
    yum update -y
fi

# Auto-execute all setup scripts inside "scripts" or "modules" or root directory
echo "[*] Installing all included VPN modules/services..."
for script in $(find . -type f -name "install*.sh" -o -name "setup-*.sh" -o -name "deploy*.sh"); do
    chmod +x "$script"
    echo "---------------------------------------"
    echo "Running: $script"
    echo "---------------------------------------"
    bash "$script"
    echo "---------------------------------------"
    echo "$script finished."
    echo
done

echo "========================================"
echo "  All services installed successfully!  "
echo "========================================"
echo
echo "Enjoy your VPN services :)"
echo

exit 0