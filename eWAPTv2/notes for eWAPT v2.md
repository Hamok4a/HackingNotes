linked-in : ahmyd-yasser
- - - 
![[Pasted image 20240712222240.png]]
![[Pasted image 20240712223648.png|675]]

![[Pasted image 20240712225048.png]]![[Pasted image 20240712232552.png|900]]
![[Pasted image 20240712234320.png]]
![[Pasted image 20240712234404.png]]
![[Pasted image 20240713004853.png]]
![[Pasted image 20240713003750.png]]

# enumrating dirs using dirb: 
`dirb https://target.com/`
  
![[Pasted image 20240713004027.png]]

# Information Gathering *Reconaissance*:
## what are we looking at ?   
- website   & domain ownership 
- IP addresses , domains  and subdomains
- hidden files  & directories 
- Hosting  infrastructure (webserver,  CMS  , Database  etc) 
- presence  of defensive  solutions like  a (WAF)
- 
## passive   recon:
 + Identifying domain names and domain ownership information.
	 + `whois`  → to get domain ownership info  , contact info 
	 + `whois app1.helwan.edu.eg`  if it said no info for that TLD  then use the website `https://whois.domaintools.com/helwan.edu.eg`
	 
	 + `Netcraft` → to get technology report
	 + `https://sitereport.netcraft.com/?url=http://app1.helwan.edu.eg` 

+ Discovering hidden/disallowed files and directories.
+ Identifying web server IP addresses & DNS records.
	- `nslookup` → gets ip address of target
	- `nslookup app1.helwan.edu.eg` → Server:192.168.1.1       Address:192.168.1.1#53
	- when using `metasploit` module `http_version`   → best way to also display the ip address of target
	- `https://dnsdumpster.com/` → website gets the dns report   
		- ![[Pasted image 20240714200812.png|400]]
	
+ Identifying web technologies being used on target sites.
	+ use `builtwith.com`  → gives results better than wapalizer 
							→ gives detailed info about used technologies on the target 

+ WAF detection.
	+ `wafw00f http://www.victim.org/` → tool to detect the waf fingerprinting and type

+ Identifying subdomains.
	+ passive subdomain enumeration via `sublist3r -d netriders.com` → uses its search engines in subs enums![[Pasted image 20240716184934.png|583]]
+ Identify website content structure
	+ `robots.txt` → contains  hidden paths from search engines (deactivate finding it via engines )
	+ `sitemap.xml` → all the site map for target 
	+ [`Dorking via Google pdf sheat cheat `](obsidian://open?vault=joyHH&file=eWAPTv2%2FGoogle-Dorks-Cheat-Sheet.pdf)
	+ exploit-db.com/google-hacking-database
## Active recon:
+ Downloading & analyzing website/web app source code.
	+ `wget` → installes  the  html code that is normally seen in view page source code 
+ Port scanning & service discovery.
+ Web server fingerprinting.
	+ `nmap -sV  target.com`  → service version (server name and version) of target
	+ or using `metasploit`  with module `http_version` 
	+ `msfconsole `  
		+ `use http_version` → searched for the module called http_version and used it 
		+ `set RHOSTS netriders.com` → set the target 
		+ `exploit` → exploited it  and found it is using  nginx server 
+ Web application scanning.
+ DNS Zone Transfers.
	+ only admin should be able to do it   ( it contains internal network topology( ips , subs))
	+ using `dig`  but not for dns lookup no it can be also for dns zone transfers
	+ `dig axfr domain@nameserverip` 
	+ best options is using `dnsenum target.com` 
+ Subdomain enumeration via Brute-Force.
+ Directories enumeration via Brute-Force. 
	+ using `metasploit`    via module `brute_dirs` 
	+ `msfconsole` 
	+ `use brute_dirs`
	+ `set rhosts netriders.com`
	+ `exploit` 


