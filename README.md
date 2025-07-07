# 🛠 Web-application-Reconnaissance-bash-script
**Bash-based Recon Automation Toolkit for Bug Bounty & Pentesters**  
_Created by: `sp3ct3rx`_

---

## 📌 Overview

MiladRecon is a modular recon automation script written in Bash, built for penetration testers and bug bounty hunters who want fast, clean, and customizable scans.

It combines the power of:
- `Nmap` for port scanning
- `Dirsearch` for content discovery
- `crt.sh` via `curl` for certificate-based subdomain enumeration

The tool generates structured output and compiles everything into a Markdown report.

---

## 🔧 Features

- 🧩 **Modular Scan Modes:** Choose from `nmap-only`, `dirsearch-only`, `crt-only`, or full scan  
- 🧠 **Interactive CLI:** Smart prompt for multiple domains  
- 📄 **Markdown Reports:** Clean recon report generation  
- ⚙️ **Lightweight & Extendable:** Just Bash + Python + curl

---

## 💻 Dependencies

- `nmap`
- `python` (for dirsearch)
- `curl`
- `jq` (for parsing JSON output)

---

## 🚀 How to Use

```bash
# Interactive mode
./recon.sh -i

# Non-interactive mode (default: full scan)
./recon.sh example.com

# Specific scan
./recon.sh -m nmap-only example.com
```

> All outputs are saved in a folder named: `example.com_recon/`

---

## 📂 Folder Structure

```
example.com_recon/
├── nmap         -> nmap scan result
├── dirsearch    -> dirsearch output (JSON)
├── crt          -> raw output from crt.sh
└── report       -> markdown formatted final report
```

---

## 🖼 Sample Output

```bash
PORT    STATE  SERVICE    VERSION
22/tcp  open   ssh        OpenSSH 7.6p1 Ubuntu
80/tcp  open   http       Apache httpd 2.4.29
```

---

## 🔐 Use Cases

- Fast recon before manual exploitation  
- Automating initial phases of bug bounty hunting  
- Supplementing penetration testing engagements

---

## 📬 Contact

Freelancer Profile: [sp3ct3rx on Freelancer](https://www.freelancer.com/u/sp3ct3rx)  
Telegram (optional): `@sp3ct3rx`  
GitHub (optional): `https://github.com/sp3ct3rx`

---

## ⚠️ License

MIT – Free to modify and distribute.
