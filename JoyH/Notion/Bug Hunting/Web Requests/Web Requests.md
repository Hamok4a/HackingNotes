# HyperText Transfer Protocol (HTTP)

- The term `hypertext` stands for text containing links to other resources.
- HTTP communication consists of ==a client== and ==a server== .
- The default port for HTTP communication is port `80` depending on the web server configuration .
- The same requests are utilized when we use the internet to visit different websites. We enter a `Fully Qualified Domain Name` (`FQDN`) as a `Uniform Resource Locator` (`URL`) to reach the desired website, like [www.hackthebox.com](http://www.hackthebox.com/).
- Resources over HTTP are accessed via a `URL` .
- Once the browser gets the IP address linked to the requested domain, it sends a GET request to the default HTTP port (e.g. `80`), asking for the root `/`  
    path. Then, the web server receives the request and processes it. By  
    default, servers are configured to return an index file when a request  
    for `/` is received.

## cURL

- In this module, we will be sending web requests through two of the  
    most important tools for any web penetration tester, a Web Browser, like  
    Chrome or Firefox, and the `cURL` command line tool.
- We see that cURL does not render the HTML/JavaScript/CSS code, unlike a web browser, but prints it in its raw format.
- We may also use cURL to download a page or a file and output the content into a file using the `-O` flag. If we want to specify the output file name, we can use the `-o` flag and specify the name. Otherwise, we can use `-O` and cURL will use the remote file name, as follows:
    
    ```
    curl -O https://academy.hackthebox.com/module/35/section/219
    ```
    

**Hypertext Transfer Protocol Secure (HTTPS):**

- one of the significant drawbacks of HTTP is that all data is transferred in clear-text. This means that anyone between the source and destination can perform a Man-in-the-middle (MiTM) attack to view the transferred data & even modify the data. [Man in The Middle attack can : ]
    - If the data is unencrypted, the hacker  
        can read it and steal it. This could include passwords, credit card  
        numbers, or other sensitive information.
    - The hacker can modify the data. This  
        could be done to change the recipient of an email, or to redirect a  
        payment to a different account.
    - The hacker can inject malicious code into the data. This could be done to steal more data, or to take control of  
        the victim's computer.
    - The hacker can simply monitor the data to  
        track the victim's activities. This could be done to learn more about  
        the victim, or to target them for a more targeted attack.

|   |   |   |
|---|---|---|
|protocol|HTTP|HTTPS|
|all data is transferred in|clear-text|encrypted format|
||can be hacked by man in the middle (MiTM) attack.||

[![](https://academy.hackthebox.com/storage/modules/35/https_clear.png)](https://academy.hackthebox.com/storage/modules/35/https_clear.png)

  

- this photo is for html you can see the password and the username at the buttom of the image.because, it is in a clear txt form so it is not secure as the https .
- We can see that the login credentials can be viewed in clear-text. This would make it easy for someone on the same network (such as a public wireless network) to capture the request and reuse the credentials for malicious purposes.

In contrast, when someone intercepts and analyzes traffic from an HTTPS request, they would see something like the following:

[![](https://academy.hackthebox.com/storage/modules/35/https_google_enc.png)](https://academy.hackthebox.com/storage/modules/35/https_google_enc.png)

As we can see, the data is transferred as a single encrypted stream,  
which makes it very difficult for anyone to capture information such as  
credentials or any other sensitive data.

- **Note:** Although the data transferred through the HTTPS protocol  
    may be encrypted, the request may still reveal the visited URL if it  
    contacted a clear-text DNS server. For this reason, it is recommended to  
    utilize encrypted DNS servers (e.g. 8.8.8.8 or 1.1.1.1), or utilize a  
    VPN service to ensure all traffic is properly encrypted.

## HTTPS Flow

Let's look at how HTTPS operates at a high level:

[![](https://academy.hackthebox.com/storage/modules/35/HTTPS_Flow.png)](https://academy.hackthebox.com/storage/modules/35/HTTPS_Flow.png)

as we said HTTPS is just a HTTP transfered with an encrypted way .

  

- The ==certificate== is a digital file that binds a ==public key== to a specific server.
- The ==pu==**==b==**==lic key== **close** is used to encrypt data.
- the ==private key== **reopen** is used to decrypt data

  

```
Client                                                  Server
-------------------------------------------------------
|                                                   |
| Requests the server's public key                 |
|                                                   |
| Receives the server's public key                 |
|                                                   |
| Encrypts the credentials with the public key     |
|                                                   |
| Sends the encrypted credentials to the server   |
|                                                   |
| Receives the encrypted credentials              |
|                                                   |
| Decrypts the credentials with the private key    |
|                                                   |
```

  

- **okay so now the server has the public key and also the private key and the client has the credentials that client wants to send to the server. the client tells the server give me the public key and then the server gives the client the public key then the client encrypt the credentials with the public key then send the credentials back to the server then the server use the private key to decrypt back the encrypted credentials .**
- so the process is s first going to the http , then going to the https :
    - which means going first to the port 80 then being redirected to the port 443.
- attacker may be able to perform an HTTP downgrade attackattacker may be able to perform an HTTP downgrade attack: which will lead to converting a https connection into HTTP only ( Down-grading).

**cURL for HTTPS:**

- curl : handeles all the HTTPS communications also not only the HTTP .
- However , if we ever contact a website with assl certifictate or an outdated one , then cURL would not procceed to protcet against the MiTM attack .and thats because :
    - curl will not be able to verify the identity of the website .
    - this means that teh attacker could use MiTM attack and intercept the transfered data or even modify it as we said before.
- if you want to bybass this certifications verfication then you can use curl `-k` flag which will lead to bybass the certification verification test like ssl certifications ,
    - Here is an example of how to use the `-k` flag with curl:
        
        `curl -k https://www.example.com`
        
- before:
    
    `KareemAlsadeq@htb[/htb]$ curl https://inlanefreight.comcurl: (60) SSL certificate problem: Invalid certificate chain More details here: https://curl.haxx.se/docs/sslcerts.html ...SNIP...`
    
    Modern web browsers would do the same, warning the user against visiting a website with an invalid SSL certificate.
    
- after:
    
    `KareemAlsadeq@htb[/htb]$ curl -k https://inlanefreight.com<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"> <html><head> ...SNIP...`
    
    As we can see, the request went through this time, and we received the response data.
    

## **HTTP Requests and Responses:**

- here i will just intercept [www.google.com](http://www.google.com) with burp to help in explaining what is **==request : response==** …..

![[Screenshot_from_2023-09-03_04-26-59.png]]

  

### HTTP Request:

Let's start by examining the following example HTTP request:

![[Screenshot_from_2023-09-03_04-47-48.png]]

The image above shows an HTTP GET request to the URL:

```
<http://inlanefreight.com/users/login.html>
```

  

The first line of any HTTP request contains three main fields 'separated by spaces':

|   |   |   |
|---|---|---|
|**Field**|**Example**|**Description**|
|`Method`|`GET`|The HTTP method or verb, which specifies the type of action to perform.|
|`Path`|`/users/login.html`|The path to the resource being accessed. This field can also be suffixed with a query string (e.g. `?username=user`).|
|`Version`|`HTTP/1.1`|The third and final field is used to denote the HTTP version.|

**Note:** HTTP version 1.X sends requests as clear-text, and uses a  
new-line character to separate different fields and different requests.  
HTTP version 2.X, on the other hand, sends requests as binary data in a  
dictionary form.

  

## HTTP Response

Once the server processes our request, it sends its response. The following is an example HTTP response:

[![](https://academy.hackthebox.com/storage/modules/35/raw_response.png)](https://academy.hackthebox.com/storage/modules/35/raw_response.png)

The first line of an ==HTTP response== contains ==two== fields separated by spaces. The first being the `HTTP version` (e.g. `HTTP/1.1`), and the second denotes the `HTTP response code` (e.g. `200 OK`).

  

- Comparison between http_request || http_response

|   |   |   |
|---|---|---|
|protocol|**request**|**response**|
|first line contains|3 things|2 things|
|what is it ?|1: Method 2:Version 3:Path|1:Http_Version 2:Http_Response_code|

- The response body:
    - is usually defined as **code**
        - `HTML` code. However, it can also respond with other code types such as `JSON`.
    - website resources :
        
        - such as images, style sheets or scripts, or even a document such as a PDF document hosted on the webserver.
        
          
        

## cURL

- In our earlier examples with cURL, we only specified the URL and got  
    the response body in return. However, cURL also allows us to preview the  
    full HTTP request and the full HTTP response.
- curl can be used in [exploit : which is "Software flaw exploited to gain unauthorized access or control systems.”].
- this is like i did in the first photo i sent from burp it is the smae process
- To view the full HTTP request and response, we can simply add the `-v` verbose flag to our earlier commands, and it should print both the request and response:
    
    ```
    KareemAlsadeq@htb[/htb]$ curl inlanefreight.com -v*   Trying SERVER_IP:80...
    * TCP_NODELAY set
    * Connected to inlanefreight.com (SERVER_IP) port 80 (\#0)> GET / HTTP/1.1
    > Host: inlanefreight.com
    > User-Agent: curl/7.65.3
    > Accept: */*
    > Connection: close
    >
    * Mark bundle as not supporting multiuse
    < HTTP/1.1 401 Unauthorized
    < Date: Tue, 21 Jul 2020 05:20:15 GMT
    < Server: Apache/X.Y.ZZ (Ubuntu)
    < WWW-Authenticate: Basic realm="Restricted Content"
    < Content-Length: 464
    < Content-Type: text/html; charset=iso-8859-1
    <
    <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
    <html><head>
    
    ...SNIP...
    ```
    
      
    

## Browser DevTools

- Most modern web browsers come with built-in developer tools (`DevTools`),  
    which are mainly intended for developers to test their web  
    applications. However, as web penetration testers, these tools can be a  
    vital asset in any web assessment we perform, as a browser (and its  
    DevTools) are among the assets we are most likely to have in every web  
    assessment exercise. In this module, we will also discuss how to utilize  
    some of the basic browser devtools to assess and monitor different  
    types of web requests.
- to get into devtools/inspector just use the keyboard_shortcut F12 .
- **devtools** contains multiple tabs :
    - Network: cause we can find things like the
        
        - methods
        - domain
        - file
        - inititaitor
        - type
        - trans
        - size
        
        all of them are for the files that are sent to the site . (data)..
        
          
        

# HTTP Headers

- We have seen examples of HTTP requests and response headers in the previous section.
- ==Headers Catagories:==
    1. General headers
    2. Entity كيان headers
    3. Request headers
    4. Response headers
    5. Security headers

  

Lets start talking about each of the ==5 header==s :

## General Headers

- [General headers](https://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html) are used in both HTTP requests and responses.
- `describe the message rather than its contents`
- from the general headers [date and connection].

|   |   |   |
|---|---|---|
|**Header**|**Example**|**Description**|
|`Date`|`Date: Wed, 16 Feb 2022 10:38:44 GMT`|Holds the date and time at which the message originated. It's preferred to convert the time to the standard [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) time zone.|
|`Connection`|`Connection: close`|Dictates if the current network connection should stay alive after  <br>the request finishes. Two commonly used values for this header are `close` and `keep-alive`. The `close` value from either the client or server means that they would like to terminate the connection, while the `keep-alive` header indicates that the connection should remain open to receive more data and input.|

  

  

  

  

## Entity Headers

- Similar to general headers, [Entity Headers](https://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html) can be `common to both the request and response`
- describe the content not like the general headers that were from the name → general headers no describtion just titles no content.

|   |   |   |
|---|---|---|
|**Header**|**Example**|**Description**|
|`Content-Type`|`Content-Type: text/html`|Used to describe the type of resource being transferred. The value  <br>is automatically added by the browsers on the client-side and returned  <br>in the server response. The `charset` field denotes the encoding standard, such as [UTF-8](https://en.wikipedia.org/wiki/UTF-8).|
|`Media-Type`|`Media-Type: application/pdf`|The `media-type` is similar to `Content-Type`, and describes the data being transferred. This header can play a crucial role in making the server interpret our input. The `charset` field may also be used with this header.|
|`Boundary`|`boundary="b4e4fbd93540"`|Acts as a marker to separate content when there is more than one in  <br>the same message. For example, within a form data, this boundary gets  <br>used as `--b4e4fbd93540` to separate different parts of the form.|
|`Content-Length`|`Content-Length: 385`|Holds the size of the entity being passed. This header is necessary  <br>as the server uses it to read data from the message body, and is  <br>automatically generated by the browser and tools like cURL.|
|`Content-Encoding`|`Content-Encoding: gzip`|Data can undergo multiple transformations before being passed. For  <br>example, large amounts of data can be compressed to reduce the message  <br>size. The type of encoding being used should be specified using the `Content-Encoding` header.|

as we saw from the Entity Headers :

1. Content-Type : describe the type of resource being transfered through client and server
2. Media-Type : describes the data being transferred , it is like the `Content-Type` but for the media .
3. Boundary: a txt that is used to separate data in diff parts of the form .
4. Content-Length : holds the size of the entity being passed .
5. Content-Encoding: (gzip) specify the content encoding type to be known for the protocols of transffering

  

  

## Request Headers

- The client sends [Request Headers](https://tools.ietf.org/html/rfc2616) in an HTTP transaction.
- used in the request only
- do not relate to the msg

|   |   |   |
|---|---|---|
|**Header**|**Example**|**Description**|
|`Host`|`Host: www.inlanefreight.com`|Used to specify the host being queried for the resource. This can be  <br>a domain name or an IP address. HTTP servers can be configured to host  <br>different websites, which are revealed based on the hostname. This makes  <br>the host header an important enumeration target, as it can indicate the  <br>existence of other hosts on the target server.|
|`User-Agent`|`User-Agent: curl/7.77.0`|The `User-Agent` header is used to describe the client  <br>requesting resources. This header can reveal a lot about the client,  <br>such as the browser, its version, and the operating system.|
|`Referer`|`Referer: http://www.inlanefreight.com/`|Denotes where the current request is coming from. For example, clicking a link from Google search results would make `https://google.com` the referer. Trusting this header can be dangerous as it can be easily manipulated, leading to unintended consequences.|
|`Accept`|`Accept: */*`|The `Accept` header describes which media types the client can understand. It can contain multiple media types separated by commas. The `*/*` value signifies that all media types are accepted.|
|`Cookie`|`Cookie: PHPSESSID=b4e4fbd93540`|Contains cookie-value pairs in the format `name=value`. A [cookie](https://en.wikipedia.org/wiki/HTTP_cookie)  <br>is a piece of data stored on the client-side and on the server, which  <br>acts as an identifier. These are passed to the server per request, thus  <br>maintaining the client's access. Cookies can also serve other purposes,  <br>such as saving user preferences or session tracking. There can be  <br>multiple cookies in a single header separated by a semi-colon.|
|`Authorization`|`Authorization: BASIC cGFzc3dvcmQK`|Another method for the server to identify clients. After successful  <br>authentication, the server returns a token unique to the client. Unlike  <br>cookies, tokens are stored only on the client-side and retrieved by the  <br>server per request. There are multiple types of authentication types  <br>based on the webserver and application type used.|

A complete list of request headers and their usage can be found [here](https://tools.ietf.org/html/rfc7231#section-5).

  

  

## Response Headers

- [Response Headers](https://tools.ietf.org/html/rfc7231#section-6) can be `used in an HTTP response and do not relate to the content`.

commonly seen in HTTP responses.

|   |   |   |
|---|---|---|
|**Header**|**Example**|**Description**|
|`Server`|`Server: Apache/2.2.14 (Win32)`|Contains information about the HTTP server, which processed the  <br>request. It can be used to gain information about the server, such as  <br>its version, and enumerate it further.|
|`Set-Cookie`|`Set-Cookie: PHPSESSID=b4e4fbd93540`|Contains the cookies needed for client identification. Browsers  <br>parse the cookies and store them for future requests. This header  <br>follows the same format as the `Cookie` request header.|
|`WWW-Authenticate`|`WWW-Authenticate: BASIC realm="localhost"`|Notifies the client about the type of authentication required to access the requested resource.|

## Security Headers

Finally, we have [Security Headers](https://owasp.org/www-project-secure-headers/).  
With the increase in the variety of browsers and web-based attacks,  
defining certain headers that enhanced security was necessary. HTTP  
Security headers are `a class of response headers used to specify certain rules and policies` to be followed by the browser while accessing the website.

|   |   |   |
|---|---|---|
|**Header**|**Example**|**Description**|
|`Content-Security-Policy`|`Content-Security-Policy: script-src 'self'`|Dictates the website's policy towards externally injected resources.  <br>This could be JavaScript code as well as script resources. This header  <br>instructs the browser to accept resources only from certain trusted  <br>domains, hence preventing attacks such as [Cross-site scripting (XSS)](https://en.wikipedia.org/wiki/Cross-site_scripting).|
|`Strict-Transport-Security`|`Strict-Transport-Security: max-age=31536000`|Prevents the browser from accessing the website over the plaintext  <br>HTTP protocol, and forces all communication to be carried over the  <br>secure HTTPS protocol. This prevents attackers from sniffing web traffic  <br>and accessing protected information such as passwords or other  <br>sensitive data.|
|`Referrer-Policy`|`Referrer-Policy: origin`|Dictates whether the browser should include the value specified via the `Referer` header or not. It can help in avoiding disclosing sensitive URLs and information while browsing the website.|

**Note:** This section only mentions a small subset of commonly seen  
HTTP headers. There are many other contextual headers that can be used  
in HTTP communications. It's also possible for applications to define  
custom headers based on their requirements. A complete list of standard  
HTTP headers can be found [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers).

  

## cURL

In the previous section, we saw how using the `-v` flag with cURL shows us the full details of the HTTP request and response.

  

- if we want to see the response Headers:value without the Body
    - then use `-I` flag
- but if we want to get everything in the response including the body of course then use the small i flag `-i` .
- `-I` response without the body `-i` with the body

```
─$ curl -I google.com
HTTP/1.1 301 Moved Permanently
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-x79roMTOVn3BhLaVZqu14A' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
Date: Sun, 03 Sep 2023 07:28:13 GMT
Expires: Tue, 03 Oct 2023 07:28:13 GMT
Cache-Control: public, max-age=2592000
Server: gws
Content-Length: 219
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
```

```
$ curl -i google.com
HTTP/1.1 301 Moved Permanently
Location: http://www.google.com/
Content-Type: text/html; charset=UTF-8
Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-Zbf5zOfjk6kQWbwEYH2Ntg' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
Date: Sun, 03 Sep 2023 07:28:22 GMT
Expires: Tue, 03 Oct 2023 07:28:22 GMT
Cache-Control: public, max-age=2592000
Server: gws
Content-Length: 219
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN

<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```

# HTTP Methods and Codes

- HTTP supports multiple methods for accessing a resource. In the HTTP  
    protocol, several request methods allow the browser to send information

## Request Methods

The following are some of the commonly used methods:

|   |   |
|---|---|
|**Method**|**Description**|
|`GET`|Requests a specific resource. Additional data can be passed to the server via query strings in the URL (e.g. `?param=value`).|
|`POST`|Sends data to the server. It can handle multiple types of input,  <br>such as text, PDFs, and other forms of binary data. This data is  <br>appended in the request body present after the headers. The POST method  <br>is commonly used when sending information (e.g. forms/logins) or  <br>uploading data to a website, such as images or documents.|
|`HEAD`|Requests the headers that would be returned if a GET request was  <br>made to the server. It doesn't return the request body and is usually  <br>made to check the response length before downloading resources.|
|`PUT`|Creates new resources on the server. Allowing this method without proper controls can lead to uploading malicious resources.|
|`DELETE`|Deletes an existing resource on the webserver. If not properly  <br>secured, can lead to Denial of Service (DoS) by deleting critical files  <br>on the web server.|
|`OPTIONS`|Returns information about the server, such as the methods accepted by it.|
|`PATCH`|Applies partial modifications to the resource at the specified location.|

- The list only highlights a few of the most commonly used HTTP  
    methods. The availability of a particular method depends on the server  
    as well as the application configuration. For a full list of HTTP  
    methods, you can visit this [link](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods).
- **Note:** Most modern web applications mainly rely on the `GET` and `POST` methods. However, any web application that utilizes REST APIs also rely on `PUT` and `DELETE`, which are used to update and delete data on the API endpoint, respectively. Refer to the [Introduction to Web Applications](https://academy.hackthebox.com/module/details/75) module for more details.

## Response Codes

HTTP status codes are used to tell the client the status of their  
request. An HTTP server can return five types of response codes:

|   |   |
|---|---|
|**Type**|**Description**|
|`1xx`|Provides information and does not affect the processing of the request.|
|`2xx`|Returned when a request succeeds.|
|`3xx`|Returned when the server redirects the client.|
|`4xx`|Signifies improper requests `from the client`. For example, requesting a resource that doesn't exist or requesting a bad format.|
|`5xx`|Returned when there is some problem `with the HTTP server` itself.|

The following are some of the commonly seen examples from each of the above HTTP method types:

|   |   |
|---|---|
|**Code**|**Description**|
|`200 OK`|Returned on a successful request, and the response body usually contains the requested resource.|
|`302 Found`|Redirects the client to another URL. For example, redirecting the user to their dashboard after a successful login.|
|`400 Bad Request`|Returned on encountering malformed requests such as requests with missing line terminators.|
|`403 Forbidden`|Signifies that the client doesn't have appropriate access to the  <br>resource. It can also be returned when the server detects malicious  <br>input from the user.|
|`404 Not Found`|Returned when the client requests a resource that doesn't exist on the server.|
|`500 Internal Server Error`|Returned when the server cannot process the request.|

For a a full list of standard HTTP response codes, you can visit this [link](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status). Apart from the standard HTTP codes, various servers and providers such as [Cloudflare](https://support.cloudflare.com/hc/en-us/articles/115003014432-HTTP-Status-Codes) or [AWS](https://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/APIError.html) implement their own codes.

  

  

# GET

Whenever we visit any URL, our browsers default to a GET request to  
obtain the remote resources hosted at that URL. Once the browser  
receives the initial page it is requesting; it may send other requests  
using various HTTP methods. This can be observed through the Network tab  
in the browser devtools, as seen in the previous section.

  

  

## HTTP Basic Auth

- When we want to use curl through a login page and we already knew the username and password then we can use the `-u` flag followed by userName: pasword.

```
KareemAlsadeq@htb[/htb]$ curl -u admin:admin http://<SERVER_IP>:<PORT>/

<!DOCTYPE html>
<html lang="en">

<head>
...SNIP...
```

or

- we can use anther way by modifing the link to make it start by
- http:// `userName:Password @` <server_IP>:<port>/

as a simple explaination just put the user : pass and then @ the rest of the link .

- Most modern web applications use login forms built with the back-end scripting language (e.g. PHP), which utilize HTTP POST requests to authenticate the users and then return a cookie to maintain their authentication.

# POST

In the previous section, we saw how `GET` requests may be  
used by web applications for functionalities like search and accessing  
pages. However, whenever web applications need to transfer files or move  
the user parameters from the URL, they utilize `POST` requests.

- post request is diff from the get on the part of putting the username and password on the URL for post we put them in the body of the request to make it more secure as we said before .

With the request data at hand, we can try to send a similar request  
with cURL, to see whether this would allow us to login as well.  
Furthermore, as we did in the previous section, we can simply  
right-click on the request and select `Copy>Copy as cURL`. However, it is important to be able to craft POST requests manually, so let's try to do so.

We will use the `-X POST` flag to send a `POST` request. Then, to add our POST data, we can use the `-d` flag and add the above data after it, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -X POST -d 'username=admin&password=admin' http://<SERVER_IP>:<PORT>/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```

**Tip:** Many login forms would redirect us to a different page once  
authenticated (e.g. /dashboard.php). If we want to follow the  
redirection with cURL, we can use the `-L` flag.

  

  

If we were successfully authenticated, we should have received a  
cookie so our browsers can persist our authentication, and we don't need  
to login every time we visit the page. We can use the `-v` or `-i` flags to view the response, which should contain the `Set-Cookie` header with our authenticated cookie:

```
KareemAlsadeq@htb[/htb]$ curl -X POST -d 'username=admin&password=admin' http://<SERVER_IP>:<PORT>/ -i

HTTP/1.1 200 OK
Date:
Server: Apache/2.4.41 (Ubuntu)
Set-Cookie: PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1; path=/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```

With our authenticated cookie, we should now be able to interact with  
the web application without needing to provide our credentials every  
time. To test this, we can set the above cookie with the `-b` flag in cURL, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -b 'PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1' http://<SERVER_IP>:<PORT>/

...SNIP...
        <em>Type a city name and hit <strong>Enter</strong></em>
...SNIP...
```

As we can see, we were indeed authenticated and got to the search  
function. It is also possible to specify the cookie as a header, as  
follows:

Code: bash

```
curl -H 'Cookie: PHPSESSID=c1nsa6op7vtk7kdis7bcnbadf1' http://<SERVER_IP>:<PORT>/
```

  

  

  

Now, let's try to use our earlier authenticated cookie, and see if we  
do get in without needing to provide our credentials. To do so, we can  
simply replace the cookie value with our own. Otherwise, we can  
right-click on the cookie and select

```
Delete All
```

, and the click on the

```
+
```

icon to add a new cookie. After that, we need to enter the cookie name, which is the part before the

```
=
```

(

```
PHPSESSID
```

), and then the cookie value, which is the part after the

```
=
```

(

```
c1nsa6op7vtk7kdis7bcnbadf1
```

).  
Then, once our cookie is set, we can refresh the page, and we will see  
that we do indeed get authenticated without needing to login, simply by  
using an authenticated cookie:

[![](https://academy.hackthebox.com/storage/modules/35/web_requests_auth_cookie.jpg)](https://academy.hackthebox.com/storage/modules/35/web_requests_auth_cookie.jpg)

As we can see, having a valid cookie may be enough to get  
authenticated into many web applications. This can be an essential part  
of some web attacks, like Cross-Site Scripting.

  

  

  

## JSON Data

Finally, let's see what requests get sent when we interact with the `City Search`  
function. To do so, we will go to the Network tab in the browser  
devtools, and then click on the trash icon to clear all requests. Then,  
we can make any search query to see what requests get sent:

  

  

  

# CRUD API

We saw examples of a `City Search` web application that  
uses PHP parameters to search for a city name in the previous sections.  
This section will look at how such a web application may utilize APIs to  
perform the same thing, and we will directly interact with the API  
endpoint.

## APIs

- There are several types of APIs
- Many apis are used to interact with databases.
- we would be able to specify the requested table and the requested row within our API query.
- using a HTTP Method like put will help us update a key with a new value as an example `curl put city to be equal to london` of course this is not the command only explaination. but the command will be like that :
    
    `curl -X PUT http://<SERVER_IP>:<PORT>/api.php/city/london ...SNIP...`
    

  

  

## CRUD

As we can see, we can easily specify the table and the row we want to  
perform an operation on through such APIs. Then we may utilize  
different HTTP methods to perform different operations on that row. In  
general, APIs perform 4 main operations on the requested database  
entity:

|   |   |   |
|---|---|---|
|Operation|HTTP Method|Description|
|`Create`|`POST`|Adds the specified data to the database table|
|`Read`|`GET`|Reads the specified entity from the database table|
|`Update`|`PUT`|Updates the data of the specified database table|
|`Delete`|`DELETE`|Removes the specified row from the database table|

These four operations are mainly linked to the commonly known CRUD  
APIs, but the same principle is also used in REST APIs and several other  
types of APIs. Of course, not all APIs work in the same way, and the  
user access control will limit what actions we can perform and what  
results we can see.

  

## Read

The first thing we will do when interacting with an API is reading  
data. As mentioned earlier, we can simply specify the table name after  
the API (e.g. `/city`) and then specify our search term (e.g. `/london`), as follows:

```
KareemAlsadeq@htb[/htb]$ curl http://<SERVER_IP>:<PORT>/api.php/city/london

[{"city_name":"London","country_name":"(UK)"}]
```

We see that the result is sent as a JSON string. To have it properly formatted in JSON format, we can pipe the output to the `jq` utility, which will format it properly. We will also silent any unneeded cURL output with `-s`, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/london | jq

[
  {
    "city_name": "London",
    "country_name": "(UK)"
  }
]
```

As we can see, we got the output in a nicely formatted output. We can also provide a search term and get all matching results:

- as we said before HTTP method get is the default so we donot need to say -X to make curl use it to read.

## Create

To add a new entry, we can use an HTTP POST request, which is quite  
similar to what we have performed in the previous section. We can simply  
POST our JSON data, and it will be added to the table. As this API is  
using JSON data, we will also set the `Content-Type` header to JSON, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -X POST http://<SERVER_IP>:<PORT>/api.php/city/ -d '{"city_name":"HTB_City", "country_name":"HTB"}' -H 'Content-Type: application/json'
```

  

## Update

Now that we know how to read and write entries through APIs, let's  
start discussing two other HTTP methods we have not used so far: `PUT` and `DELETE`. As mentioned at the beginning of the section, `PUT` is used to update API entries and modify their details, while `DELETE` is used to remove a specific entity.

**Note:** The HTTP `PATCH` method may also be used to update API entries instead of `PUT`. To be precise, `PATCH` is used to partially update an entry (only modify some of its data "e.g. only city_name"), while `PUT` is used to update the entire entry. We may also use the HTTP `OPTIONS`  
method to see which of the two is accepted by the server, and then use  
the appropriate method accordingly. In this section, we will be focusing  
on the `PUT` method, though their usage is quite similar.

Using `PUT` is quite similar to `POST` in this  
case, with the only difference being that we have to specify the name of  
the entity we want to edit in the URL, otherwise the API will not know  
which entity to edit. So, all we have to do is specify the `city` name in the URL, change the request method to `PUT`, and provide the JSON data like we did with POST, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -X PUT http://<SERVER_IP>:<PORT>/api.php/city/london -d '{"city_name":"New_HTB_City", "country_name":"HTB"}' -H 'Content-Type: application/json'
```

We see in the example above that we first specified `/city/london` as our city, and passed a JSON string that contained `"city_name":"New_HTB_City"` in the request data. So, the london city should no longer exist, and a new city with the name `New_HTB_City` should exist. Let's try reading both to confirm:

```
KareemAlsadeq@htb[/htb]$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/london | jq
```

```
KareemAlsadeq@htb[/htb]$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City | jq

[
  {
    "city_name": "New_HTB_City",
    "country_name": "HTB"
  }
]
```

Indeed, we successfully replaced the old city name with the new city.

**Note:** In some APIs, the `Update`  
operation may be used to create new entries as well. Basically, we would  
send our data, and if it does not exist, it would create it. For  
example, in the above example, even if an entry with a `london`  
city did not exist, it would create a new entry with the details we  
passed. In our example, however, this is not the case. Try to update a  
non-existing city and see what you would get.

## DELETE

Finally, let's try to delete a city, which is as easy as reading a  
city. We simply specify the city name for the API and use the HTTP `DELETE` method, and it would delete the entry, as follows:

```
KareemAlsadeq@htb[/htb]$ curl -X DELETE http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City
```

```
KareemAlsadeq@htb[/htb]$ curl -s http://<SERVER_IP>:<PORT>/api.php/city/New_HTB_City | jq
[]
```

As we can see, after we deleted `New_HTB_City`, we get an empty array when we try reading it, meaning it no longer exists.

**Exercise:** Try to delete any of the cities you  
added earlier through POST requests, and then read all entries to  
confirm that they were successfully deleted.

With this, we are able to perform all 4 `CRUD` operations  
through cURL. In a real web application, such actions may not be allowed  
for all users, or it would be considered a vulnerability if anyone can  
modify or delete any entry. Each user would have certain privileges on  
what they can `read` or `write`, where `write`  
refers to adding, modifying, or deleting data. To authenticate our user  
to use the API, we would need to pass a cookie or an authorization  
header (e.g. JWT), as we did in an earlier section. Other than that, the  
operations are similar to what we practiced in this section.

  

  

### Conclusion

This module covered the essentials of HTTP requests and how we can  
send HTTP requests with different HTTP methods. Such concepts are  
necessary for beginning to work with web applications. A successful  
security professional must understand and be able to explain the core  
concepts of the technologies that they are charged with attacking,  
defending, and securing.

As you work on testing web applications, you may primarily be working  
with proxying tools like Burp Suite or ZAP, so we advise working  
through the [Using Web Proxies](https://academy.hackthebox.com/module/details/110)  
module next. However, understanding HTTP requests and their different  
methods is essential for starting to use such proxying tools. Also, on  
many occasions, being able to perform quick tests using browser dev  
tools or cURL would be much faster than switching to a different tool.  
Furthermore, cURL knowledge is essential for scripting web requests and  
automating different tests, which may become very handy for exploit  
development in the future.

**Module Key Takeaways**

- An overview of the HyperText Transfer Protocol (HTTP) and HTTPS (HTTP Secure) protocols
- Working with HTTP requests and responses and their headers
- An understanding of common HTTP methods and response codes
- Interacting with APIs
- Leveraging `cURL` for interacting with web applications.
- Leveraging `Browser DevTools` for interacting with web applications.

  

---