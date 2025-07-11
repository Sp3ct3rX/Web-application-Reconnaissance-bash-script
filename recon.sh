#!/bin/bash

# MiladRecon 2.0 - Underground Edition
# Advanced recon automation with styled output and reporting

source ./scan.lib 


# Color definitions
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

while getopts "m:i" OPTION; do
    case $OPTION in 
        m)
            MODE=$OPTARG
            ;;
        i)
            INTERACTIVE=true
            ;;
    esac
done

validate_domain() {
    local domain=$1
    if [[ ! "$domain" =~ ^[a-zA-Z0-9.-]+$ ]]; then
        echo -e "${RED}[!] Invalid domain format: $domain${RESET}"
        return 1
    fi
    return 0
}

scan_domain() {
    DOMAIN=$1
    validate_domain $DOMAIN || return

    DIRECTORY="${DOMAIN}_recon"
    echo -e "${BLUE}[+] Creating directory: $DIRECTORY${RESET}"
    mkdir -p "$DIRECTORY"

    case $MODE in
        nmap-only)
            nmap_scan ;;
        dirsearch-only)
            dirsearch_scan ;;
        crt-only)
            crt_scan ;;
        *)
            nmap_scan
            dirsearch_scan
            crt_scan ;;
    esac
}

report_domain() {
    DOMAIN=$1
    validate_domain $DOMAIN || return

    echo -e "${YELLOW}[#] Creating recon report for $DOMAIN ...${RESET}"
    TODAY=$(date)
    REPORT_FILE="$DIRECTORY/report.md"

    echo -e "# Recon Report for $DOMAIN\nGenerated: $TODAY\n" > "$REPORT_FILE"

    if [ -f "$DIRECTORY/nmap" ]; then
        echo -e "\n## Nmap Results\n\n\`\`\`" >> "$REPORT_FILE"
        grep -P -i "([A-Za-z0-9]+(\s+[A-Za-z0-9]+)+)" "$DIRECTORY/nmap" >> "$REPORT_FILE"
        echo -e "\`\`\`" >> "$REPORT_FILE"
    fi

    if [ -f "$DIRECTORY/dirsearch" ]; then
        echo -e "\n## Dirsearch Results\n\n\`\`\`" >> "$REPORT_FILE"
        jq -r ".results[] | select(.status >= 200 and .status <= 399)" "$DIRECTORY/dirsearch" >> "$REPORT_FILE"
        echo -e "\`\`\`" >> "$REPORT_FILE"
    fi

    if [ -f "$DIRECTORY/crt" ]; then
        echo -e "\n## crt.sh Results\n\n\`\`\`" >> "$REPORT_FILE"
        jq -r ".[] | .name_value" "$DIRECTORY/crt" | sort | uniq >> "$REPORT_FILE"
        echo -e "\`\`\`" >> "$REPORT_FILE"
    fi

    echo -e "${GREEN}[✓] Report saved to $REPORT_FILE${RESET}"
}

if [ "$INTERACTIVE" ]; then
    echo -e "${GREEN}[*] MiladRecon 2.0 - Interactive Mode${RESET}"
    echo -e "Type a domain to start or 'quit' to exit."
    while true; do
        read -p "Enter domain: " INPUT
        [ "$INPUT" = "quit" ] && break
        scan_domain "$INPUT"
        report_domain "$INPUT"
    done
else
    for domain in "${@:$OPTIND}"; do
        scan_domain "$domain"
        report_domain "$domain"
    done
fi
