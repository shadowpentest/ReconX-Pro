import os
import subprocess
import shutil

def check_tools(tools):
    print("[*] Checking required tools...")
    for tool in tools:
        if shutil.which(tool) is None:
            print(f"[✘] {tool} not found! Please install it.")
        else:
            print(f"[✔] {tool} is installed.")

def main():
    domain = input("Enter target domain: ").strip()
    if not domain:
        print("[-] No domain entered.")
        return

    tools = ["subfinder", "amass", "assetfinder", "httpx", "dnsx", "rustscan", "nmap", "whatweb", "ffuf", "nuclei", "gowitness", "jq"]
    check_tools(tools)

    print(f"\n[*] Starting recon for {domain}...\n")
    subprocess.call(["bash", "reconx_pro.sh", domain])

if __name__ == "__main__":
    main()
    