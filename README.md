<h1 align="center">
  🕵️ Web Application Reconnaissance — Bash Script
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Bash-%2300ff88?style=for-the-badge&logo=gnu-bash&logoColor=white" />
  <img src="https://img.shields.io/badge/Recon-Tool-%239f7aea?style=for-the-badge&logo=linux" />
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20WSL-darkgreen?style=for-the-badge&logo=linux&logoColor=white" />
</p>

---

## 🔍 Overview

`Web-application-Reconnaissance-bash-script` is a modular and lightweight reconnaissance toolkit built in pure Bash. It automates the recon phase of web application penetration testing with real-world tools and techniques.

---

## ⚙️ Features

- 🔍 **Nmap scan** – Ports & services detection  
- 📂 **Dirsearch scan** – Directory brute-force using extensions and recursion  
- 🌐 **crt.sh parsing** – Subdomain enumeration via public certificate transparency logs  
- 📝 **Auto report generation** – All results structured in a clean format

---

## 🎯 Why This Tool?

- No Python/Go/Node required — just pure Bash.
- Fully customizable.
- Perfect for quick recon, CTFs, and bug bounty automation.

---

## 📦 Tools Used

- `nmap`  
- `dirsearch` (Python tool called inside script)  
- `curl`  
- `jq` (for formatting JSON output)

---

## 🚀 Quick Start

```bash
git clone https://github.com/sp3ct3rx/Web-application-Reconnaissance-bash-script.git
cd Web-application-Reconnaissance-bash-script
chmod +x recon.sh scan.lib
./recon.sh -i
```

---

## 📁 Output Sample

The tool will create a `{DOMAIN}_recon` folder and store:
- `nmap` results
- `dirsearch` JSON output
- `crt.sh` subdomains
- A final `report` file with filtered and readable data

---

## 📸 Screenshots

*(Add some screenshots here of the terminal in action!)*

---

## ☠️ Author

**Milad (sp3ct3rx)**  
🔗 [GitHub Profile](https://github.com/sp3ct3rx)  
📬 Telegram: `@sp3ct3rxx`  
📎 Freelancer: [freelancer.com/u/sp3ct3rx](https://freelancer.com/u/sp3ct3rx)

---

## ⭐️ Star This Repo

If this script helped you or saved your time during recon, please consider giving it a ⭐️ — it motivates me to release more tools for the community.
