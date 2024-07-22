---
tags:
  - Methodology
  - Recon
---
# Frame work
- [[Web-check]]
[Web Check](https://web-check.xyz/)
# [[Whois]] and Reverse Whois
 searches for the registrant and owner information of each known domain.
```bash
whois example.com
```
## Reverse 
 finding obscure or internal domains not otherwise disclosed to the public. 
 [Reverse Whois Lookup - ViewDNS.info](https://viewdns.info/reversewhois/)
# IP Addresses 
## Get them
get the website ‘s IP addresses using [[Nslookup]]
```bash
nslookup facebook.com
Server: 192.168.0.1
Address: 192.168.0.1#53
Non-authoritative answer:
Name: facebook.com
Address: 157.240.2.35
```
## Reverse lookup
 look for domains hosted on the same server, given an IP or domain.
### [[whois]]
 If the organization has a dedicated IP range, any IP you find in that range belongs to that organization
```bash
whois 157.240.2.35
---SNIP---
NetRange: 157.240.0.0 - 157.240.255.255
---SNIP---
``` 
### [ViewDNS.info](https://viewdns.info/reversewhois/)
## ASNs
Autonomous system numbers (ASNs) identify the owners of these networks.
![[Pasted image 20240228210226.png]]
`-h` → sets the WHOIS server to retrieve information from, and www.whois.cymru.com is a database that translates IPs to ASNs. 
# Certificate Parsing
 the Secure Sockets Layer ([[SSL]]) certificates used to encrypt web traffic. An SSL certificate’s Subject Alternative Name field lets certificate owners specify additional host names that use the same certificate
-  `crt.sh` 
	`https://crt.sh/?q=facebook.com&output=json`
- `Censys`  
- `Cert Spotter`
# Sub-Domains
##  enumeration
- [[Subfinder]]
	Finds new subdomains
	```bash
	subfinder -d "example.com" -all -cs
	```
- [[columbus]]
- [[Google Dorks]]
	```
	site:example.com filetype:jsp
	site:example.com filetype:go
	site:example.com filetype:cfm
	site:example.com filetype:php
	site:example.com filetype:asp
	site:example.com inurl:'&'
	```
	- [[Lopseg]]
		[Lopseg | Google Dork](https://www.lopseg.com.br/google-dork)

## [[Brute Forcing]] Subdomains
- [[Gobuster]]
	[[Brute Forcing]] to discover subdomains, directories, and files on target web servers.
	```bash
	gobuster dns -d target_domain -w wordlist
	```
- [[Altdns]]
	 discovers subdomains with names that are permutations of other subdomain names.
	```bash
	altdns -i subdomains.txt -o data_output -w words.txt
	```
- Getting Resolvers
	`Download a list` → [GitHub - trickest/resolvers: The most exhaustive list of reliable DNS resolvers.](https://github.com/trickest/resolvers)
	 [[DNS Validator]] →  `dnsvalidator -tl https://public-dns.info/nameservers.txt -threads 20 -o resolvers.txt` (Slow)
- DNS Wordlist
	```bash
	wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
	```
- [[Shuffledns]]
	Gets the valid subdomains
	```bash
	shuffledns -d example.com -w dns-wordlist.txt -r resolvers.txt
	```
## Directory Brute Forcing
- [[Gobuster]]
	```bash
	gobuster dir -u https://mysite.com/path/to/folder -c 'session=123456' -t 50 -w common-files.txt -x .php,.html
	```
	`-t` → Threads (default 10)
	`-w` → wordlist
	`-x` → file extensions to look for
	`dir` → Directory Brute Forcing mode
## Screen shooting
 automatically verify that a page is hosted on each location.
 - [[Eyewitness]]
## [[ZAP#Spider|Spidering the Site]]
starts with a page to visit. It then identifies all the URLs embedded on the page and visits them.
## Third party Hosting
-  [[AWS - S3 Unauthenticated Enum|S3 buckets]]

## For BB targets (block recon on their websites)
- [[Nmap]] 
	```bash
	nmap -F -T1 website_ipaddresss -v 
	```
### 
- [[FFUF]] 
	```bash
	ffuf -w /path/to/wordlist.txt -u website_URL -p 2
	```
# Service Enumeration 
## Active Scanning
Send requests to connect to the target machine’s ports to look for open ones.
- [[Nmap]]
	```bash
	nmap example.com
	```
## Passive Scanning
Use third-party resources to learn about a machine’s ports without interacting with the server.
- [[Shodan]]
- [[Censys]]
- [[Project Sonar]]
# Monitoring 
[[gungir]]
[GitHub - jhaddix/KingOfBugBountyTips](https://github.com/jhaddix/KingOfBugBountyTips)





# Finding Programs
![[Google Dorks#Finding Programs]]
# Sub-Domains
##  enumeration
- [[Subfinder]]
	```bash
	subfinder -d "example.com" -all -cs
	```
- [[columbus]] [Columbus Project - Advanced subdomain discovery service.](https://columbus.elmasy.com/)
- [[Lopseg]] [Lopseg | Google Dork](https://www.lopseg.com.br/google-dork)
## [[Brute Forcing]] Subdomains
- [[Gobuster]]
	[[Brute Forcing]] to discover subdomains, directories, and files on target web servers.
	```bash
	gobuster dns -d target_domain -w wordlist
	```
- [[Altdns]]
	 discovers subdomains with names that are permutations of other subdomain names.
	```bash
	altdns -i subdomains.txt -o data_output -w words.txt
	```
- Getting Resolvers
	`Download a list` → [GitHub - trickest/resolvers: The most exhaustive list of reliable DNS resolvers.](https://github.com/trickest/resolvers)
	 [[DNS Validator]] →  `dnsvalidator -tl https://public-dns.info/nameservers.txt -threads 20 -o resolvers.txt` (Slow)
- DNS Wordlist
	```bash
	wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
	```
- [[Shuffledns]]
	Gets the valid subdomains
	```bash
	shuffledns -d example.com -w dns-wordlist.txt -r resolvers.txt
	```
## Directory Brute Forcing
- [[Gobuster]]
	```bash
	gobuster dir -u https://mysite.com/path/to/folder -c 'session=123456' -t 50 -w common-files.txt -x .php,.html
	```
	`-t` → Threads (default 10)
	`-w` → wordlist
	`-x` → file extensions to look for
	`dir` → Directory Brute Forcing mode
- [[FeroxBuster]]
```bash
	feroxbuster -u $TARGET  --extract-links --insecure --proxy http://127.0.0.1:8080	
```
## Screen shooting
 automatically verify that a page is hosted on each location.
 - [[Eyewitness]]
## [[ZAP#Spider|Spidering the Site]]
starts with a page to visit. It then identifies all the URLs embedded on the page and visits them.
## Third party Hosting
-  [[AWS - S3 Unauthenticated Enum|S3 buckets]]

## For BB targets (block recon on their websites)
- [[Nmap]] 
	```bash
	nmap -F -T1 website_ipaddresss -v 
	```
### 
- [[FFUF]] 
	```bash
	ffuf -w /path/to/wordlist.txt -u website_URL -p 2
	```
