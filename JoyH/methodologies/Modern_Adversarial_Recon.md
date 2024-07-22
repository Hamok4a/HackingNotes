---
tags:
  - Bug-Bounty
  - Recon
---
> Good `Recon`  has a lot of “jumping” around (after finding a subdomain we make recon on it and so on)
## What we are looking for
- Apex Domains ` www.test.com `
- Subdomains ` www.sub.test.com `
- IP Addresses
- Services
- Contextual Business & Tech Intel
## Searching for IP Addresses
[[ASN]] a collection of IP networks and routers using:
![[ASN#Tools]]

## Port Scanning
- [[Nabbu]]
- [[Smap]] (Passive Scan using [[Shodan]])
## Apex Domains enumeration
- [[check_md]]
- [[Karma v2]]
- [[Shosubgo]]
## [[SSL Certificate]]
**We are looking for:**
- subdomains
- apex domains
- internal domains
We Get SSL Certificates by scanning the whole internet
### Tools
- [[IP Ranges]] List all IP ranges from: Google, … 
- [[Cloud Recon]]
-  [[Kaeferjaeger]] Cloud Recon Backup(Scans all the major cloud providers every week. and offer them to download)
- [[AWSScrape]]
## Subdomain Scrapping
- Using [[Google Dorks]] with Subtracting the sub domains we discover
	![[Pasted image 20240115165857.png]]
- [[Amass]]
- [[Subfinder]]
- [[bbot]]
### Top API for Recon
- [Projectdiscovery.io | Chaos](https://chaos.projectdiscovery.io/#/)
- [Sign in to GitHub · GitHub](https://github.com/settings/tokens)
- [Netlas](https://netlas.io/)
### Github Enumeration
- [[github-subdomains]]
-
![[Pasted image 20240115005443.png]]