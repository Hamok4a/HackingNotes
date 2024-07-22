---
tags:
  - Recon
  - Tool
---
- amass =>  `amass enum -brute -active -d domain.com -o amass-output.txt`
- httprobe => `cat amass-output.txt | httprobe -p http:81 -p http:3000 -p https:3000 -p http:3001 -p https:3001 -p http:8000 -p http:8080 -p https:8443 -c 50 | tee online-domains.txt`
- anew =>  `cat new-output.txt | anew old-output.txt | httprobe`
- dnsgen   =>  `- cat amass-output.txt | dnsgen - | httprobe`
- aquatone => `cat domains-endpoints.txt | aquatone`
#Zseanos-Methodology