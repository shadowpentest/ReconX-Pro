# ReconX-Pro
A robust, fault-tolerant bug bounty recon framework with multi-tool fallback, fuzzing, and vulnerability scanning.

ReconX-Pro – By ShadowPentest

# 🔍 ReconX-Pro

**Advanced Recon Tool for Bug Bounty & Pentesting – Layered, Fault-Tolerant, Fully Automated**

---

## 🧠 What It Does

ReconX-Pro combines powerful recon tools with fallback logic to make sure even if one fails, others cover it. It automates:
- 🔎 Subdomain Enumeration (Subfinder, Amass, Assetfinder, crt.sh)
- 🌐 Live detection (httpx)
- 📡 DNS resolution (dnsx)
- 🔥 Port Scanning (RustScan + Nmap)
- 🧰 Tech fingerprinting (WhatWeb)
- 🕳️ Recursive fuzzing (ffuf)
- 🛡️ Vulnerability scan (Nuclei)
- 📸 Screenshots (Gowitness)

Everything is saved neatly under `recon-data/<target>/`.

---

## 📦 Installation (Linux / WSL)

sudo apt update && sudo apt install -y git curl jq nmap whatweb ffuf python3-pip
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/owasp-amass/amass@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/RustScan/RustScan@latest
go install github.com/sensepost/gowitness@latest

How to Run

Option 1 – Python Wrapper
python3 reconx_pro.py

Option 2 – Direct Bash
bash
Copy
Edit
chmod +x reconx_pro.sh
./reconx_pro.sh example.com


OutoUt
recon-data/<target>/
├── all_subs.txt
├── live.txt
├── resolved.txt
├── ports_*.txt
├── tech.txt
├── nuclei.txt
└── screens/

License & Author
License: MIT

Author: @shadowpentest

Made with 🔥 by ShadowPentest – Hunt Smart. Hack Hard. 💀
