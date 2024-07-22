---
tags:
  - Methodology
  - Bug-Bounty
  - Recon
---
![[Pasted image 20240325170353.png|1100]]
# Tech Profiling
- Extensions 
	- Wappalyzer
	- what runs
- command line
	- webanalyze
# Finding CVE’s and Misconfigs
- [[Nuclei]]
- [[Jaeles Scanner]]
## Tips
- Make templates for new vulns
- don’t use nuclei on highly known target , use it on a website that not many  testers have seen them
# Port Scanning 
- [[Nabbu]]
# Content Discovery 
### Tools
- [[FeroxBuster]]
### Lists
[Assetnote Wordlists](https://wordlists.assetnote.io/)
### Technology 
````col
```col-md
flexGrow=1
===
![[Pasted image 20240326055422.png|725]]
```
```col-md
flexGrow=1
===
![[Pasted image 20240326055513.png|750]]
```
````

## Historical 
- [[waymore]]
	fetches known URLs from AlienVault's [Open Threat Exchange](https://otx.alienvault.com), the Wayback Machine, Common Crawl, and URLScan for any given domain.
- [[wordlistgen]]
	generate wordlist from urls
- [[Trash Compactor]]
	Removes URLs with the same functionality 
## Endpoints
## Mobile
[[APKLeaks]]
##  **Changes*
- Targets Newsletter
- Affiliate Programs (use application for long time) 
- Googling Conference Talks
- Monitoring the domain for changes
## Tips
- Config files for DB connections
- where the admin login and routes/endpoints are
	- Recon Recursively  
	```json
	https://someapp.com/admin/ 401
	https://someapp.com/admin/dashboard/ 401
	https://someapp.com/admin/dashboard/members 200 
	```
# Application Analysis
## Understanding the application 
1. How does the app pass data?
	```json
	resource?parameter=value&param2=value
	Method -> /route/resource/sub-resource/...
	```
2. How/Where does the app talk to users
	![[Pasted image 20240326073824.png|458]]
3. Does the site have multi-tenancy or user Levels 
![[Pasted image 20240326074058.png|499]]
4. Has there been past security research & Vulns 
5. What Threat model do they use
6. How does the app handle **[[XSS (Cross Site Scripting)|XSS]]** , **[[CSRF]]**, **CODE INJECTION ([[SQL Injection|SQL]], [[Server-Side Template Injection (SSTI)| Template]] ….)**
	- Google the web framework to understand how it protects from **xss** or What the output encoding option it uses
# Spidering
- Using [[ZAP]]
	[[ZAP#Spider]]
- Command line Tools
	- [[Hakrawler]]
	- [[GoSpider]]
# [[JS]]
- [[xnLinkFinder]]
- [[Custom Elements Language Server]]
# Parameters Analysis
![[Parameters Analysis]]
- [[sus_params]]