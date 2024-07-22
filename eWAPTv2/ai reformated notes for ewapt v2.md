
---

**LinkedIn**: [ahmyd-yasser](https://linkedin.com/in/ahmyd-yasser)

---

![[Pasted image 20240712222240.png]]
![[Pasted image 20240712223648.png|675]]
![[Pasted image 20240712225048.png|475]]
![[Pasted image 20240712232552.png|475]]
![[Pasted image 20240712234320.png]]
![[Pasted image 20240712234404.png]]
![[Pasted image 20240713004853.png]]
![[Pasted image 20240713003750.png]]

# Enumerating Directories using `dirb`
```sh
dirb https://target.com/
```
![[Pasted image 20240713004027.png]]

# Information Gathering *Reconnaissance*

## What are we looking at?
- Website & domain ownership 
- IP addresses, domains, and subdomains
- Hidden files & directories 
- Hosting infrastructure (web server, CMS, Database, etc.)
- Presence of defensive solutions like a WAF

## Passive Reconnaissance:
### Identifying domain names and domain ownership information
- `whois` → to get domain ownership info, contact info 
  ```sh
  whois app1.helwan.edu.eg
  ```
  If no info for that TLD, use the website [DomainTools WHOIS](https://whois.domaintools.com/helwan.edu.eg)

- `Netcraft` → to get technology report
  [Netcraft Site Report](https://sitereport.netcraft.com/?url=http://app1.helwan.edu.eg)

### Discovering hidden/disallowed files and directories
### Identifying web server IP addresses & DNS records
- `nslookup` → gets IP address of target
  ```sh
  nslookup app1.helwan.edu.eg
  ```
  Output: Server: 192.168.1.1 Address: 192.168.1.1#53

- When using `metasploit` module `http_version` → displays the IP address of target
- [DNSDumpster](https://dnsdumpster.com/) → website gets the DNS report
  ![[Pasted image 20240714200812.png|400]]

### Identifying web technologies being used on target sites
- [BuiltWith](https://builtwith.com/) → provides detailed info about used technologies on the target

### WAF Detection
- `wafw00f http://www.victim.org/` → tool to detect the WAF fingerprinting and type

### Identifying subdomains
- Passive subdomain enumeration via `sublist3r`
  ```sh
  sublist3r -d netriders.com
  ```
   ![[Pasted image 20240716184934.png|658]]





- Passive subdomain enumeration via `subfinder`
  ```sh
  subfinde2r -d netriders.com -all
  ```

### Identify website content structure
- `robots.txt` → contains hidden paths from search engines
- `sitemap.xml` → all the site map for target
- [Dorking via Google PDF Cheat Sheet](obsidian://open?vault=joyHH&file=eWAPTv2%2FGoogle-Dorks-Cheat-Sheet.pdf)
- [Exploit-DB Google Hacking Database](https://www.exploit-db.com/google-hacking-database)

## Active Reconnaissance:
### Downloading & analyzing website/web app source code
- `wget` → installs the HTML code that is normally seen in view page source code 

### Port scanning & service discovery
- `nmap -sV target.com` → service version (server name and version) of target
- Using `metasploit` with module `http_version`
  ```sh
  msfconsole
  use http_version
  set RHOSTS netriders.com
  exploit
  ```
  Found it is using nginx server 

### Web application scanning
- Using `nikto` for Vulnerability scanning  
```sh
  nikto -h netriders.academy
  ```
### DNS Zone Transfers
- Only admin should be able to do it (it contains internal network topology: IPs, subs)
- Using `dig` for DNS zone transfers
  ```sh
  dig axfr domain@nameserverip
  ```
- Best option is using `dnsenum`
  ```sh
  dnsenum target.com -o findings_nikto.html -Format htm
  ```

### Subdomain enumeration via Brute-Force
### Directories enumeration via Brute-Force
- Using `gobuster`  via  mode  `dir`
```sh
  gobuster dir -u https://netriders.academy -w 
  ```
- Using `metasploit` via module `brute_dirs`
  ```sh
  msfconsole
  use brute_dirs
  set RHOSTS netriders.com
  exploit
  ```

---
