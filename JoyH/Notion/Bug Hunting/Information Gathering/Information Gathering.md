---

# During this process, our objective is to identify as much information as we can from the following areas:

|   |   |
|---|---|
|Area|Description|
|Domains and Subdomains|Often, we are given a single domain or perhaps a list of domains and  <br>subdomains that belong to an organization. Many organizations do not  <br>have an accurate asset inventory and may have forgotten both domains and  <br>subdomains exposed externally. This is an essential part of the  <br>reconnaissance phase. We may come across various subdomains that map  <br>back to in-scope IP addresses, increasing the overall attack surface of  <br>our engagement (or bug bounty program). Hidden and forgotten subdomains  <br>may have old/vulnerable versions of applications or dev versions with  <br>additional functionality (a Python debugging console, for example). Bug  <br>bounty programs will often set the scope as something such as `*.inlanefreight.com`, meaning that all subdomains of `inlanefreight.com`, in this example, are in-scope (i.e., `acme.inlanefreight.com`, `admin.inlanefreight.com`,  <br>and so forth and so on). We may also discover subdomains of subdomains.  <br>For example, let's assume we discover something along the lines of `admin.inlanefreight.com`. We could then run further subdomain enumeration against this subdomain and perhaps find `dev.admin.inlanefreight.com`  <br>as a very enticing target. There are many ways to find subdomains (both  <br>passively and actively) which we will cover later in this module.|
|IP ranges|Unless we are constrained to a very specific scope, we want to find  <br>out as much about our target as possible. Finding additional IP ranges  <br>owned by our target may lead to discovering other domains and subdomains  <br>and open up our possible attack surface even wider.|
|Infrastructure|We want to learn as much about our target as possible. We need to  <br>know what technology stacks our target is using. Are their applications  <br>all ASP.NET? Do they use Django, PHP, Flask, etc.? What type(s) of  <br>APIs/web services are in use? Are they using Content Management Systems  <br>(CMS) such as WordPress, Joomla, Drupal, or DotNetNuke, which have their  <br>own types of vulnerabilities and misconfigurations that we may  <br>encounter? We also care about the web servers in use, such as IIS,  <br>Nginx, Apache, and the version numbers. If our target is running  <br>outdated frameworks or web servers, we want to dig deeper into the  <br>associated web applications. We are also interested in the types of  <br>back-end databases in use (MSSQL, MySQL, PostgreSQL, SQLite, Oracle,  <br>etc.) as this will give us an indication of the types of attacks we may  <br>be able to perform.|
|Virtual Hosts|Lastly, we want to enumerate virtual hosts (vhosts), which are  <br>similar to subdomains but indicate that an organization is hosting  <br>multiple applications on the same web server. We will cover vhost  <br>enumeration later in the module as well.|

# We can break the information gathering process into two main categories:

|   |   |
|---|---|
|Category|Description|
|Passive information gathering|We do not interact directly with the target at this stage. Instead,  <br>we collect publicly available information using search engines, whois,  <br>certificate information, etc. The goal is to obtain as much information  <br>as possible to use as inputs to the active information gathering phase.|
|Active information gathering|We directly interact with the target at this stage. Before  <br>performing active information gathering, we need to ensure we have the  <br>required authorization to test. Otherwise, we will likely be engaging in  <br>illegal activities. Some of the techniques used in the active  <br>information gathering stage include port scanning, DNS enumeration,  <br>directory brute-forcing, virtual host enumeration, and web application  <br>crawling/spidering.|

# those are the things we get info about :

![[Screenshot_from_2023-09-07_09-42-51.png]]

## three commands tools to get these info

1. whois
2. nslookup
3. dig

# Passive Subdomain Enumeration

we get subdomains that lies behind the main domain

cause their security will be lower than the main domain and they are a good entry point for us to get into the system .

## tools to (subdomain getting ):

virustotal.com:

- we put the domain name on the search and it gives us alot of data including the subdomains and the history of this domains interactions on the internet ….and more.

  

  

SSL/TLS certificates:

- [https://censys.io](https://censys.io/)
- [https://crt.sh](https://crt.sh/)
    
    when using the [crt.sh](http://crt.sh) site it will give us results but it is much better to use this command with this site and curl to produce a txt file that contains all the subdomains it is very effective
    
    ```
     export TARGET="teslamotors.com"
     curl -s "https://crt.sh/?q=${TARGET}&output=json" | jq -r '.[] | "\(.name_value)\n\(.common_name)"' | sort -u > "${TARGET}_crt.sh.txt"
    ```
    
    |   |   |
    |---|---|
    |||
    |`curl -s`|Issue the request with minimal output.|
    |`https://crt.sh/?q=<DOMAIN>&output=json`|Ask for the json output.|
    |`jq -r '.[]' "\(.name_value)\n\(.common_name)"'`|Process the json output and print certificate's name value and common name one per line.|
    |`sort -u`|Sort alphabetically the output provided and removes duplicates.|
    

  

We also can manually perform this operation against a target using OpenSSL via:

Certificate Transparency

```
KareemAlsadeq@htb[/htb]$ export TARGET="facebook.com"KareemAlsadeq@htb[/htb]$ export PORT="443"KareemAlsadeq@htb[/htb]$ openssl s_client -ign_eof 2>/dev/null <<<$'HEAD / HTTP/1.0\r\n\r' -connect "${TARGET}:${PORT}" | openssl x509 -noout -text -in - | grep 'DNS' | sed -e 's|DNS:|\n|g' -e 's|^\*.*||g' | tr -d ',' | sort -u*.facebook.com
*.facebook.net
*.fbcdn.net
*.fbsbx.com
*.m.facebook.com
*.messenger.com
*.xx.fbcdn.net
*.xy.fbcdn.net
*.xz.fbcdn.net
facebook.com
messenger.com
```

  

# Automating Passive Subdomain Enumeration

### TheHarvester

[TheHarvester](https://github.com/laramies/theHarvester)  
is a simple-to-use yet powerful and effective tool for early-stage  
penetration testing and red team engagements. We can use it to gather  
information to help identify a company's attack surface. The tool  
collects `emails`, `names`, `subdomains`, `IP addresses`, and `URLs` from various public data sources for passive information gathering. For now, we will use the following modules:

|   |   |
|---|---|
|||
|[Baidu](http://www.baidu.com/)|Baidu search engine.|
|`Bufferoverun`|Uses data from Rapid7's Project Sonar - [www.rapid7.com/research/project-sonar/](http://www.rapid7.com/research/project-sonar/)|
|[Crtsh](https://crt.sh/)|Comodo Certificate search.|
|[Hackertarget](https://hackertarget.com/)|Online vulnerability scanners and network intelligence to help organizations.|
|`Otx`|AlienVault Open Threat Exchange - [https://otx.alienvault.com](https://otx.alienvault.com/)|
|[Rapiddns](https://rapiddns.io/)|DNS query tool, which makes querying subdomains or sites using the same IP easy.|
|[Sublist3r](https://github.com/aboul3la/Sublist3r)|Fast subdomains enumeration tool for penetration testers|
|[Threatcrowd](http://www.threatcrowd.org/)|Open source threat intelligence.|
|[Threatminer](https://www.threatminer.org/)|Data mining for threat intelligence.|
|`Trello`|Search Trello boards (Uses Google search)|
|[Urlscan](https://urlscan.io/)|A sandbox for the web that is a URL and website scanner.|
|`Vhost`|Bing virtual hosts search.|
|[Virustotal](https://www.virustotal.com/gui/home/search)|Domain search.|
|[Zoomeye](https://www.zoomeye.org/)|A Chinese version of Shodan.|

To automate this, we will create a file called sources.txt with the following contents.

TheHarvester

```
KareemAlsadeq@htb[/htb]$ cat sources.txtbaidu
bufferoverun
crtsh
hackertarget
otx
projecdiscovery
rapiddns
sublist3r
threatcrowd
trello
urlscan
vhost
virustotal
zoomeye
```

Once the file is created, we will execute the following commands to gather information from these sources.

TheHarvester

```
KareemAlsadeq@htb[/htb]$ export TARGET="facebook.com"KareemAlsadeq@htb[/htb]$ cat sources.txt | while read source; do theHarvester -d "${TARGET}" -b $source -f "${source}_${TARGET}";done<SNIP>
*******************************************************************
*  _   _                                            _             *
* | |_| |__   ___    /\  /\__ _ _ ____   _____  ___| |_ ___ _ __  *
* | __|  _ \ / _ \  / /_/ / _` | '__\ \ / / _ \/ __| __/ _ \ '__| *
* | |_| | | |  __/ / __  / (_| | |   \ V /  __/\__ \ ||  __/ |    *
*  \__|_| |_|\___| \/ /_/ \__,_|_|    \_/ \___||___/\__\___|_|    *
*                                                                 *
* theHarvester 4.0.0                                              *
* Coded by Christian Martorella                                   *
* Edge-Security Research                                          *
* cmartorella@edge-security.com                                   *
*                                                                 *
*******************************************************************


[*] Target: facebook.com

[*] Searching Urlscan.

[*] ASNS found: 29
--------------------
AS12578
AS13335
AS13535
AS136023
AS14061
AS14618
AS15169
AS15817

<SNIP>
```

When the process finishes, we can extract all the subdomains found and sort them via the following command:

TheHarvester

```
KareemAlsadeq@htb[/htb]$ cat *.json | jq -r '.hosts[]' 2>/dev/null | cut -d':' -f 1 | sort -u > "${TARGET}_theHarvester.txt"
```

Now we can merge all the passive reconnaissance files via:

TheHarvester

```
KareemAlsadeq@htb[/htb]$ cat facebook.com_*.txt | sort -u > facebook.com_subdomains_passive.txtKareemAlsadeq@htb[/htb]$ cat facebook.com_subdomains_passive.txt | wc -l11947
```

So far, we have managed to find 11947 subdomains merging the passive  
reconnaissance result files. It is important to note here that there are  
many more methods to find subdomains passively. More possibilities are  
shown, for example, in the [OSINT: Corporate Recon](https://academy.hackthebox.com/course/preview/osint-corporate-recon) module.

# Passive Infrastructure Identification

- gives us informations about the
    
    - severs
    - `https://sitereport.netcraft.com`
    
    Some interesting details we can observe from the report are:
    
    |   |   |
    |---|---|
    |||
    |`Background`|General information about the domain, including the date it was first seen by Netcraft crawlers.|
    |`Network`|Information about the netblock owner, hosting company, nameservers, etc.|
    |`Hosting history`|Latest IPs used, webserver, and target OS.|
    
      
    

# Active Infrastructure Identification

- the infrastructure of a web application is what keeps it running .
- infra_structure is the underground building

  

- HTTP headers:
    
      
    
- Whatweb tool :
    
    get information like :
    
    1. web server version .
    2. installed modules .
    3. enabled services .
    4. content management system
    
- new used tools
    1. wafw00f
    2. wappalyzer
    3. whatweb
    4. `https://sitereport.netcraft.com`
    5. TheHarvester
    6. virustotal.com
    7. SSL/TLS certificates
    8. whois
    9. nslookup
    10. dig