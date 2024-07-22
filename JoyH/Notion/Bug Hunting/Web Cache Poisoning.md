---
tags:
  - "#web_cache_poisoning"
---
# What is WebCachePoisoning?
- attacker exploits the ==behavior of a web server and cache== 
- this leads to a ==harmful response send to other users ==
# How to exploit WCP?
- First Phase: 
	- Me ( the attacker ) must work out how to elicit a response from the  
		backend server that inadvertently contains some kind of dangerous payload on it . 
- Second Phase:  
	- Once  I find out how to elicit that response from the backend i should make sure that it gets  cached in the backend server and subsequently served to the intended victims . 
# How does a web cache work?
- To understand how web cache poisoning vulnerabilities arise, it is important to have a basic understanding of how web caches work.

- If a server had to send a new response to every single HTTP request separately, this would likely overload the server, resulting in latency issues and a poor user experience, especially during busy periods. Caching is primarily a means of reducing such issues.

- The cache sits between the server and the user, where it saves (caches) the responses to particular requests, usually for a fixed amount of time. If another user then sends an equivalent request, the cache simply serves a copy of the cached response directly to the user, without any interaction from the back-end. This greatly eases the load on the server by reducing the number of duplicate requests it has to handle.
- server → cache  (contains the stored responses for a set of requests that are already requested by users)
- ![[Pasted image 20240210134049.png|640]]
- # Cache keys
	- When the cache receives an HTTP request, it first has to determine whether there is a cached response that it can serve directly, or whether it has to forward the request for handling by the back-end server. Caches identify equivalent requests by comparing a predefined subset of the request's components, known collectively as the "cache key". Typically, this would contain the request line and `Host` header. Components of the request that are not included in the cache key are said to be "unkeyed".
## Constructing a web cache poisoning attack

- Generally speaking, constructing a basic web cache poisoning attack involves the following steps:


	1. [Identify and evaluate unkeyed inputs](https://portswigger.net/web-security/web-cache-poisoning#identify-and-evaluate-unkeyed-inputs)
	2. [Elicit a harmful response from the back-end server](https://portswigger.net/web-security/web-cache-poisoning#elicit-a-harmful-response-from-the-back-end-server)
	3. [Get the response cached](https://portswigger.net/web-security/web-cache-poisoning#get-the-response-cached)

- You can identify unkeyed inputs manually by adding random inputs to requests and observing whether or not they have an effect on the response. This can be obvious, such as reflecting the input in the response directly, or triggering an entirely different response. However, sometimes the effects are more subtle and require a bit of detective work to figure out. You can use tools such as Burp Comparer to compare the response with and without the injected input, but this still involves a significant amount of manual effort.
- #### Param Miner

- Fortunately, you can automate the process of identifying unkeyed inputs by adding the [Param Miner](https://portswigger.net/bappstore/17d2949a985c4b7ca092728dba871943) extension to Burp from the BApp store. To use Param Miner, you simply right-click on a request that you want to investigate and click "Guess headers". Param Miner then runs in the background, sending requests containing different inputs from its extensive, built-in list of headers. If a request containing one of its injected inputs has an effect on the response, Param Miner logs this in Burp, either in the "Issues" pane if you are using [Burp Suite Professional](https://portswigger.net/burp/pro), or in the "Output" tab of the extension ("Extensions" > "Installed" > "Param Miner" > "Output") if you are using [Burp Suite Community Edition](https://portswigger.net/burp/communitydownload).
- ![[Pasted image 20240210140114.png|637]]
# Get the response cached

- Manipulating inputs to elicit a harmful response is half the battle, but it doesn't achieve much unless you can cause the response to be cached, which can sometimes be tricky.

- Whether or not a response gets cached can depend on all kinds of factors, such as the file extension, content type, route, status code, and response headers. You will probably need to devote some time to simply playing around with requests on different pages and studying how the cache behaves. Once you work out how to get a response cached that contains your malicious input, you are ready to deliver the exploit to potential victims.
- ![[Pasted image 20240210140525.png|860]]
# Using web cache poisoning to deliver an [XSS](https://portswigger.net/web-security/cross-site-scripting) attack
- Perhaps the simplest web cache poisoning vulnerability to exploit is when unkeyed input is reflected in a cacheable response without proper sanitization.

- For example, consider the following request and response:
	`GET /en?region=uk HTTP/1.1 Host: innocent-website.com X-Forwarded-Host: innocent-website.co.uk HTTP/1.1 200 OK Cache-Control: public <meta property="og:image" content="https://innocent-website.co.uk/cms/social.png" />`

- Here, the value of the `X-Forwarded-Host` header is being used to dynamically generate an Open Graph image URL, which is then reflected in the response. Crucially for web cache poisoning, the `X-Forwarded-Host` header is often unkeyed. In this example, the cache can potentially be poisoned with a response containing a simple XSS payload:

	`GET /en?region=uk HTTP/1.1 Host: innocent-website.com X-Forwarded-Host: a."><script>alert(1)</script>" HTTP/1.1 200 OK Cache-Control: public <meta property="og:image" content="https://a."><script>alert(1)</script>"/cms/social.png" />`

- If this response was cached, all users who accessed `/en?region=uk` would be served this XSS payload. This example simply causes an alert to appear in the victim's browser, but a real attack could potentially steal passwords and hijack user accounts.
#### Read more
- [Exploiting cross-site scripting vulnerabilities](https://portswigger.net/web-security/cross-site-scripting/exploiting)
---
# Using web cache poisoning to exploit unsafe handling of resource imports:
- Solved it it was very easy .
# Using web cache poisoning to exploit cookie-handling vulnerabilities
- Cookies are often used to dynamically generate content in a response . 
- Ex: `cookie: language=en`  this will load the corresponding version of the page (english version)
- Usually the things that gets cached are the  (cache key which is =  request line + host )  
- If the  cookie for example here isnot cached all the user will get the english version of the website even if they choosed other version they will get the english one . The default one . 
- ![[Pasted image 20240211021956.png]]
# Using multiple headers to exploit web cache poisoning vulnerabilities
X-forwarded-proto   → https or http 
X-forwarded-scheme : nothttps → nothttps    (sends the request with http only ) 
![[Pasted image 20240211025921.png]]
# Cache control directives 
- We need to make the evil stuff cached
- ![[Pasted image 20240211074846.png|780]]
- The  `vary header ` specifies a list of the headers available that are addational and can be part of the sent  cach key . 
- If the attacker knows that `userAgent: ` is part of the cache key he can understnad from that that a cache made for non mobile will not e sent to mobile adn vice versa  . 
- So they use something like that to target the most amount of users according to which of the user’s  aggent ( devices type ) . 
# Exploiting cache implementation flaws 
