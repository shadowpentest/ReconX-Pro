#!/bin/bash

DOMAIN=$1
OUTDIR=recon-data/$DOMAIN
mkdir -p $OUTDIR

echo "[+] Starting ReconX-Pro for $DOMAIN"

# Subdomain Enumeration
echo "[*] Running Subfinder, Amass, Assetfinder, crt.sh..."
subfinder -d $DOMAIN -silent >> $OUTDIR/subs.txt 2>/dev/null
amass enum -passive -d $DOMAIN >> $OUTDIR/subs.txt 2>/dev/null
assetfinder --subs-only $DOMAIN >> $OUTDIR/subs.txt 2>/dev/null
curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" | jq -r '.[].name_value' >> $OUTDIR/subs.txt
cat $OUTDIR/subs.txt | sort -u > $OUTDIR/all_subs.txt

# Live Subdomains
echo "[*] Checking live subdomains with httpx..."
httpx -l $OUTDIR/all_subs.txt -silent -status-code -title -tech-detect > $OUTDIR/live.txt

# DNS Resolution
echo "[*] Resolving domains with DNSx..."
dnsx -l $OUTDIR/all_subs.txt -o $OUTDIR/resolved.txt

# Port Scanning
cat $OUTDIR/resolved.txt | cut -d' ' -f2 | sort -u > $OUTDIR/ips.txt
for ip in $(cat $OUTDIR/ips.txt); do
    rustscan -a $ip --ulimit 5000 -- -sC -sV -oN $OUTDIR/ports_$ip.txt
done

# Technology Fingerprinting
echo "[*] Running WhatWeb..."
cat $OUTDIR/live.txt | cut -d' ' -f1 > $OUTDIR/urls.txt
for url in $(cat $OUTDIR/urls.txt); do
    whatweb $url >> $OUTDIR/tech.txt
done

# Recursive Directory Fuzzing
echo "[*] Recursive Fuzzing with FFUF..."
for url in $(cat $OUTDIR/urls.txt); do
    ffuf -u $url/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -recursion -recursion-depth 2 -t 50 -of json -o $OUTDIR/fuzz_$(echo $url | cut -d/ -f3).json
done

# Vulnerability Scanning
echo "[*] Running Nuclei scan..."
nuclei -l $OUTDIR/urls.txt -t cves/ -o $OUTDIR/nuclei.txt

# Screenshotting
echo "[*] Capturing screenshots with Gowitness..."
gowitness file -f $OUTDIR/urls.txt -P $OUTDIR/screens

echo "[✔] Recon completed. Output saved to $OUTDIR"
