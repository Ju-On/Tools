## subdomain hunting with amass, assetfinder, subfinder into found.txt
## httprobe to verify alive domains, dedup, strips https:// > alive.txt
## gowitness to screenshot > urlofdomain/screenshots
## http only, replace in httprobe section with `| httprobe -prefer-https -p http | grep http |`
## add # infront of the subdomain tool to exclude scan in events scan hangs, likely due to rate limiting
## Example: ./subdomainhunterV2.sh test.com

#!/bin/bash

# Use the first argument as the domain name
domain=$1
# Define colors
RED="\033[1;31m"
RESET="\033[0m"

# Define directories
base_dir="$domain"
info_path="$base_dir/info"
subdomain_path="$base_dir/subdomains"
screenshot_path="$base_dir/screenshots"

# Create directories if they don't exist
for path in "$info_path" "$subdomain_path" "$screenshot_path"; do
    if [ ! -d "$path" ]; then
        mkdir -p "$path"
        echo "Created directory: $path"
    fi
done

# Total number of steps for progress calculation
total_steps=6
current_step=0

# Function to display progress
show_progress() {
    percent=$((current_step * 100 / total_steps))
    progress_bar="["

    # Fill progress bar
    for ((i=0; i<percent/2; i++)); do
        progress_bar="${progress_bar}="
    done
    for ((i=percent/2; i<50; i++)); do
        progress_bar="${progress_bar} "
    done

    progress_bar="${progress_bar}] ${percent}%"
    echo -ne "$progress_bar\r"
}

# Step 1: Whois lookup
echo -e "${RED} [+] Checking who it is ... ${RESET}"
whois "$domain" > "$info_path/whois.txt"
current_step=$((current_step + 1))
show_progress

# Step 2: Subfinder
echo -e "${RED} [+] Launching subfinder ... ${RESET}"
subfinder -d "$domain" > "$subdomain_path/found.txt"
current_step=$((current_step + 1))
show_progress

# Step 3: Assetfinder
echo -e "${RED} [+] Running assetfinder ... ${RESET}"
assetfinder "$domain" | grep "$domain" >> "$subdomain_path/found.txt"
current_step=$((current_step + 1))
show_progress

# Step 4: Amass
##echo -e "${RED} [+] Running Amass for subdomain enumeration ... ${RESET}"
##amass enum -d "$domain" -o - >> "$subdomain_path/found.txt"  # Append Amass results to found.txt
##current_step=$((current_step + 1))
##show_progress

# Step 5: Checking live subdomains
echo -e "${RED} [+] Checking what's alive ... ${RESET}"
cat "$subdomain_path/found.txt" | grep "$domain" | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a "$subdomain_path/alive.txt"
current_step=$((current_step + 1))
show_progress

# Step 6: Taking screenshots
echo -e "${RED} [+] Taking screenshots ... ${RESET}"
gowitness scan file -f "$subdomain_path/alive.txt" --screenshot-path "$screenshot_path/" --no-http
current_step=$((current_step + 1))
show_progress

echo -e "${RESET}\nCompleted all steps!"

